import pandas as pd
import requests


class Client:

    def __init__(self, api_key):
        '''
        Initialize method

        '''
        self.api_key = api_key
        self.BASE_URL = "https://api.nal.usda.gov/fdc/v1"

    def valid_checker(self, response):
        '''
        Method to validate the response body

        response: response body from requests library
        '''
        if response.status_code == 200:
            return True
        else:
            return False

    def food(self, fdcId):
        '''
        Method to get a food information given food Id

        arg:
            fdcId: str
        '''
        url = f"{self.BASE_URL}/food/{fdcId}"
        response = requests.get(url=url,
                                params={"api_key": self.api_key})

        # check if valid
        if self.valid_checker(response):
            return response.json()
        else:
            return {}

    def get_food_list(self, pageSize=50, pageNumber=1, to_df=False, raw=False):
        '''
        Method to get all food list

        args:
            pageSize: int
            pageNumber: int
            to_df: bool
            raw: bool
        '''
        url = f"{self.BASE_URL}/foods/list"
        data = {"pageSize": pageSize,
                "pageNumber": pageNumber}
        response = requests.post(url=url,
                                 params={"api_key": self.api_key},
                                 json=data)

        # check if not valid
        if not self.valid_checker(response):
            return

        r_json = response.json()

        # if raw = True, return the raw json file
        if raw:
            return r_json

        # if to_df = False, return the dict format
        if not to_df:
            return {food["description"]: food["fdcId"] for food in r_json}
        else:
            return pd.DataFrame({"desc": [food["description"] for food in r_json],
                                 "fdcId": [food["fdcId"] for food in r_json]})

    def food_search(self, query, pageSize=50, pageNumber=1, to_df=False, raw=False):
        '''
        Method for food search engine

        args:
            query: str
            pageSize: int
            pageNumber: int
            to_df: bool
            raw: boolean
        '''
        url = f"{self.BASE_URL}/foods/search"
        data = {"query": query,
                "pageSize": pageSize,
                "pageNumber": pageNumber,
                "sortOrder": "asc"}
        response = requests.post(url=url,
                                 params={"api_key": self.api_key},
                                 json=data)

        # check if not valid
        if not self.valid_checker(response):
            return

        r_json = response.json()

        # if raw = True, return the raw json file
        if raw:
            return r_json

        # if to_df = False, return the dict format
        if not to_df:
            return {food["description"]: food["fdcId"] for food in response.json()["foods"]}
        else:
            return pd.DataFrame({"desc": [food["description"] for food in response.json()["foods"]],
                                 "fdcId": [food["fdcId"] for food in response.json()["foods"]]})

    def get_nutrition(self, fdcId):
        '''
        Method to get nutrition given food id

        arg:
            fdcId : int

        '''

        result = self.food(fdcId)
        result = result[0]["labelNutrients"]
        return result
