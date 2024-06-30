# Clean_CRC_GEOJSON_PROPERTIES
Will remove all overwriting properties objects in each feature of a geojson constructed for CRC that is not a isDefault feature.
The isDefaults will be placed at the beginning of the feature collection.

For clarification:
	-In a isDefault feature, the properties to remain.
	-In a feature that is a Type:Point but has a TEXT property, the TEXT properties object will stay but all other objects will be removed from the properties.
	-In a feature that is anything else, it will remove the properties objects.

Run:
1) Launch CMD prompt.
2) CD to the directory the .py is in.
3) `python Clean_CRC_GeoJSON_Properties.py "%USERPROFILE%\Desktop\test.geojson" "%USERPROFILE%\Desktop\cleaned_test.geojson" --pretty`

Note: if you leave off the `--pretty`, it should export as a compressed geojson format.
