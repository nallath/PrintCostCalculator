from PyQt5.QtCore import  QObject, QUrl, pyqtProperty, pyqtSignal
from UM.Extension import Extension
from UM.PluginRegistry import PluginRegistry
import os.path
from PyQt5.QtQuick import QQuickView
from PyQt5.QtQml import QQmlComponent, QQmlContext
from UM.Application import Application

from UM.i18n import i18nCatalog
i18n_catalog = i18nCatalog("PrintCostCalculator")


class PrintCostCalculator(QObject,  Extension):
    def __init__(self, parent = None):
        super().__init__(parent)
        self._cost_view = None
        self.addMenuItem(i18n_catalog.i18n("Calculate"), self.showPopup)
        Application.getInstance().activeMachineChanged.connect(self._onActiveMachineChanged)
        self._print_information = None
    
    materialAmountChanged = pyqtSignal()
    
    def _onActiveMachineChanged(self):
        self._print_information = Application.getInstance()._print_information  #Yes, this is bad. Theres no getter/setter :(
        self._print_information.materialAmountChanged.connect(self.materialAmountChanged)

    @pyqtProperty(float, notify = materialAmountChanged)
    def materialAmount(self):
        return self._print_information.materialAmount
    
    def showPopup(self):
        if self._cost_view is None:
            path = QUrl.fromLocalFile(os.path.join(PluginRegistry.getInstance().getPluginPath("PrintCostCalculator"), "PrintCostCalculator.qml"))
            self._component = QQmlComponent(Application.getInstance()._engine, path)

            self._context = QQmlContext(Application.getInstance()._engine.rootContext())
            self._context.setContextProperty("manager", self)
            self._cost_view = self._component.create(self._context)
        self._cost_view.show()