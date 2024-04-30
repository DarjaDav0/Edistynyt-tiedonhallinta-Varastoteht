import contextlib
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

@contextlib.contextmanager
def get_db(cnx_type='oltp'):
    _db = None
    try:
        #oltp tietokannan osoite
        if cnx_type == 'oltp':
            cnx_str = 'mysql+mysqlconnector://root:@localhost/lapinamk_varasto'
        elif cnx_type == 'olap':  # Corrected here
            cnx_str = 'mysql+mysqlconnector://root:@localhost/edistynyt_varasto_OLAP'
        else:
            raise ValueError("Invalid connection type. Expected 'oltp' or 'olap'.")
        engine = create_engine(cnx_str)
        db_session = sessionmaker(bind=engine)
        _db = db_session()
        yield _db
    except Exception as e:
        print(e)
    finally:
        if _db is not None:
            _db.close()