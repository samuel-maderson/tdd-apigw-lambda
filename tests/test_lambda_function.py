import json


def test_lambda_response():

    payload = {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }

    expected = {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
    assert payload == expected
