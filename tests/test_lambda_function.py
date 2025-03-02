from unittest import mock
import json


def test_lambda_response():
    payload = {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }

    expected = {
        'statusCode': 200,
        'body': json.dumps('Mocked message!')
    }
    # with mock.patch('json.dumps', return_value=json.dumps('Mocked message!')):
    #     payload['body'] = json.dumps('Hello from Lambda!')

    assert payload == expected
