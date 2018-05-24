#/bin/sh

/etc/init.d/postgresql start

su -c "psql -c \"create database code_or_die\"" postgres
su -c "psql -c \"alter user postgres with password '123456'\"" postgres

echo "IP" $(hostname -I)

cd /code-or-die
python3.6 app.py
