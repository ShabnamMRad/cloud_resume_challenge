import json
import boto3

dynamodb = boto3.resource('dynamodb', region_name='eu-central-1')


def lambda_handler(event, context):
    table = dynamodb.Table('cv_cloud_shabnam')
    response = table.get_item(Key={
        'id_nr': '1'
    })
    item = response['Item']
    item['viewer_nr'] = item['viewer_nr'] + 1
    table.put_item(Item=item)

    return {
        'statusCode': 200,
        'body': json.dumps(str(item['viewer_nr'])),
        'headers': {
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json'
        }
    }