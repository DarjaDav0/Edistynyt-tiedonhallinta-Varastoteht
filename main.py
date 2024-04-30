import sqlalchemy
from db import get_db
from user import user_etl
from rental_item import rental_item_etl

    
def main():
    #user_etl()
    rental_item_etl()


if __name__ == '__main__':
    main()