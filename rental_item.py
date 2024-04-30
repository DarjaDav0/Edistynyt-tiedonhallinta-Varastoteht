import sqlalchemy
from db import get_db

def _get_rental_items(_db):
    _query = sqlalchemy.text('''SELECT 
    rental_items.id AS item_id, 
    rental_items.name AS item_name, 
    users.id AS user_id, 
    users.username AS username, 
    rental_item_statuses.id AS status_id, 
    rental_item_statuses.status AS status, 
    rental_items.address AS address, 
    categories.id AS category_id, 
    categories.name AS category
FROM 
    rental_items
INNER JOIN 
    users ON rental_items.created_by_id = users.id
INNER JOIN 
    rental_item_statuses ON rental_item_statuses_id = rental_item_statuses.id
INNER JOIN 
    categories ON rental_items.categories_id = categories.id''')
    rows = _db.execute(_query)
    rental_items = rows.mappings().all()
    return rental_items

def rental_item_etl():
    with get_db() as _db:
        rental_items = _get_rental_items(_db)
    with get_db(cnx_type='olap') as _dw:
        try:
            for rental_item in rental_items:
                _query = sqlalchemy.text('''INSERT INTO rental_item_dim(item_id, item_name, user_id, username, status_id, status, address, category_id, category) 
                    VALUES (:item_id, :item_name, :user_id, :username, :status_id, :status, :address, :category_id, :category) 
                    ON DUPLICATE KEY UPDATE 
                    item_id = VALUES(item_id),
                    username = VALUES(item_name), 
                    user_id = VALUES(user_id), 
                    username = VALUES(username),
                    status_id = VALUES(status_id),
                    status = VALUES(status),
                    address = VALUES(address),
                    category_id = VALUES(category_id),
                    category = VALUES(category)''')
                _dw.execute(_query, {'item_id': rental_item['item_id'], 'item_name': rental_item['item_name'], 'user_id': rental_item['user_id'], 'username': rental_item['username'], 'status_id': rental_item['status_id'], 'status': rental_item['status'], 'address': rental_item['address'], 'category_id': rental_item['category_id'], 'category': rental_item['category']})
            _dw.commit()
        except Exception as e:
            _dw.rollback()
            print(e)