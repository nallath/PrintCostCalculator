# Copyright (c) 2015 Jaime van Kessel
# PluginCostCalculator is released under the terms of the AGPLv3 or higher.

from . import PrintCostCalculator
from UM.i18n import i18nCatalog
i18n_catalog = i18nCatalog("PrintCostCalculator")
def getMetaData():
    return {
        "type": "extension",
        "plugin": 
        {
            "name": "Print Cost Calculator",
            "author": "Jaime van Kessel",
            "version": "15.06",
            "description": i18n_catalog.i18nc("Description of plugin","Extension to quickly calculate print costs")
        }
    }
        
def register(app):
    return { "extension": PrintCostCalculator.PrintCostCalculator()}
