import boto3
import botocore
from json import loads
from datetime import datetime

class AmazonS3():
    def __init__(self, aws_region: str, aws_acces_key: str, aws_secret_key: str) -> None:

        self.aws_region = aws_region
        self.aws_acces_key = aws_acces_key
        self.aws_secret_key = aws_secret_key
        self.formatted_dates = []
        try:
            self.client = boto3.client(
                service_name = 's3',
                region_name = self.aws_region,
                aws_access_key_id= self.aws_acces_key,
                aws_secret_access_key = self.aws_secret_key
            )
        except botocore.exceptions.ClientError as error:
            raise

    def _send_bucket_request(self, foldername, ACL='private'):
        try:
            response = self.client.create_bucket(
                ACL=ACL,
                Bucket=foldername,
                CreateBucketConfiguration={
                    "LocationConstraint": self.aws_region
                }
            )
            if response['ResponseMetadata']['HTTPStatusCode'] == 200:
                return response
            
        except botocore.exceptions.ClientError as error:
            raise error
    
    def create_bucket(self, foldername: str, ACL='private'):
        response = self._send_bucket_request(foldername, ACL)
        return response

    def _add_data_formater(self, response):
        for bucket in response['Buckets']:
            name = bucket['Name']
            creation_datetime = bucket['CreationDate']
            formatted_date = format_datetime(creation_datetime)
            self.formatted_dates.append({'Name': name, 'CreationDate': formatted_date})

        return self.formatted_dates

    def list_buckets(self):
        try:
            response = self.client.list_buckets()
            formated_response = self._add_data_formater(response)
            return formated_response
        except botocore.exceptions.ClientError as error:
            raise error        

    def delete_buckets(self, bucket_name):
        try:
            response = self.client.list_objects_v2(Bucket=bucket_name)

            if 'Contents' in response:
                objects = [{'Key': obj['Key']} for obj in response['Contents']]
                self.client.delete_objects(Bucket=bucket_name, Delete={'Objects': objects})    
                print(f"Todos os objetos foram excluídos do bucket '{bucket_name}'.")   

            self.client.delete_bucket(Bucket=bucket_name)
            print(f"Bucket '{bucket_name}' excluído permanentemente.")

        except Exception as e:
            print(f"Erro ao excluir o bucket '{bucket_name}': {e}")

    def upload_folder_content(self):
        pass

    
def format_datetime(datetime_obj):
    return datetime_obj.strftime("%d-%m-%Y %H:%M:%S")

