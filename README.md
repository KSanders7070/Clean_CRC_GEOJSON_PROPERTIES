# Clean_CRC_GEOJSON_PROPERTIES
Will remove all overwriting properties objects in each feature of a geojson constructed for CRC that is not an isDefault feature.
The isDefaults will be placed at the beginning of the feature collection.

**For clarification:**
* In a isDefault feature, the properties will remain as they are.  
* In a feature that is a "Type:Point" but has a TEXT property, the TEXT properties object will remain but all other objects will be removed from the properties.  
* In all other features properties objects will be removed.

**Run:**
1) Download the `Run_Clean_CRC_GeoJSON_Properties.bat` and `Clean_CRC_GeoJSON_Properties.py` and place them in the same directory.
2) Launch the .bat and follow the prompts.

_or..._

1) Download `Clean_CRC_GeoJSON_Properties.py`
2) Launch CMD prompt.
3) CD to the directory the .py is in.
4) Modify as needed and paste the following: `python Clean_CRC_GeoJSON_Properties.py "%USERPROFILE%\Desktop\test.geojson" "%USERPROFILE%\Desktop\cleaned_test.geojson" --pretty`

Note: if you leave off the `--pretty`, it should export as a compressed geojson format.
