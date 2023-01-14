backend = "postgresql"
pgsql_connection = host=127.0.0.1 port=5432 user=mt_user password=mt_password dbname=minetest
pgsql_player_connection = (same parameters as above)
pgsql_readonly_connection = (same parameters as above)
pgsql_auth_connection = (same parameters as above)
pgsql_mod_storage_connection = (same parameters as above)




services.postgresql = {
    enable = true;
    settings = {
        shared_buffers = "1GB";
    };
    ensureDatabases = ["minetest"];
    ensureUsers = {

    };
};




backend = postgresql
pgsql_connection=user=minetest dbname=minetest