import json
import argparse

def clean_geojson(input_file, output_file, pretty_print):
    with open(input_file, 'r', encoding='utf-8') as f:
        geojson_data = json.load(f)
    
    if 'features' not in geojson_data or not isinstance(geojson_data['features'], list):
        raise ValueError("Invalid GeoJSON format: 'features' array not found or not a list.")

    # Separate isDefaults features from other features
    is_defaults = []
    other_features = []

    for feature in geojson_data['features']:
        if 'properties' in feature:
            if 'isSymbolDefaults' in feature['properties'] or 'isLineDefaults' in feature['properties'] or 'isTextDefaults' in feature['properties']:
                is_defaults.append(feature)
            else:
                if feature['geometry']['type'] == 'Point' and 'text' in feature['properties']:
                    # Keep only 'text' property in Point features with 'text'
                    feature['properties'] = {'text': feature['properties']['text']}
                else:
                    # Remove all properties except 'text' in Point features with 'text'
                    feature['properties'] = {}

                other_features.append(feature)
        else:
            other_features.append(feature)

    # Create a new GeoJSON object with cleaned features
    cleaned_geojson = {
        'type': 'FeatureCollection',
        'features': is_defaults + other_features
    }

    # Write the cleaned GeoJSON to output file
    with open(output_file, 'w', encoding='utf-8') as f:
        if pretty_print:
            json.dump(cleaned_geojson, f, indent=4)
        else:
            json.dump(cleaned_geojson, f)

    print(f"Cleaned GeoJSON written to {output_file}")

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Clean GeoJSON file by removing non-default properties.')
    parser.add_argument('source', help='Source GeoJSON file to clean')
    parser.add_argument('output', help='Output file path for cleaned GeoJSON')
    parser.add_argument('--pretty', action='store_true', help='Pretty-print output with indent of 4 spaces')
    
    args = parser.parse_args()
    
    # Call clean_geojson function with arguments
    clean_geojson(args.source, args.output, args.pretty)
