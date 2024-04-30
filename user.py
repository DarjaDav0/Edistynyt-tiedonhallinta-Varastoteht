import sqlalchemy
from db import get_db

#kysely kantaan oltp edistynyt_varasto1(1)
def _get_users(_db):
    _query = sqlalchemy.text('SELECT users.id AS user_id, username, roles_id AS role_id, role FROM users INNER JOIN roles ON users.roles_id = roles.id')
    rows = _db.execute(_query)
    users = rows.mappings().all()
    return users

#user_dim taulun täyttö kantaan olap edistynyt_varasto_OLAP
def user_etl():
    with get_db() as _db:
        users = _get_users(_db)
    with get_db(cnx_type='olap') as _dw:
        try:
            for user in users:
                _query = sqlalchemy.text('''INSERT INTO user_dim(user_id, username, role_id, role) 
                    VALUES (:user_id, :username, :role_id, :role) 
                    ON DUPLICATE KEY UPDATE 
                    username = VALUES(username), 
                    role_id = VALUES(role_id), 
                    role = VALUES(role)''')
                _dw.execute(_query, {'user_id': user['user_id'], 'username': user['username'], 'role_id': user['role_id'], 'role': user['role']})
            _dw.commit()
        except Exception as e:
            _dw.rollback()
            print(e)