# Practice - Oracle Database

```sh
# Clone
git clone https://github.com/kem198/practice-oracle-db.git
cd practice-oracle-db

# (Optional) Change password for admin users (sys, system, pdbadmin)
vim docker-compose.yml
  # Change the value of `ORACLE_PWD=__ENTER_ADMIN_PASSWORD_HERE__`

# (Optional) Change password for application user (APPUSER)
vim script/setup/01_create_examples_table.sql
  # Change the value of `CREATE USER APPUSER IDENTIFIED BY __ENTER_APPUSER_PASSWORD_HERE__;`

# Start service
docker compose up -d

# Login
docker compose exec db sqlplus sys/__ENTER_ADMIN_PASSWORD_HERE__@XEPDB1 as sysdba
docker compose exec db sqlplus system/__ENTER_ADMIN_PASSWORD_HERE__@XEPDB1
docker compose exec db sqlplus pdbadmin/__ENTER_ADMIN_PASSWORD_HERE__@XEPDB1
docker compose exec db sqlplus APPUSER/__ENTER_APPUSER_PASSWORD_HERE__@XEPDB1
```

## References

- [Oracle Database Express Edition - Repository Detail](https://container-registry.oracle.com/ords/f?p=113:4:7883439364890:::4:P4_REPOSITORY,AI_REPOSITORY,AI_REPOSITORY_NAME,P4_REPOSITORY_NAME,P4_EULA_ID,P4_BUSINESS_AREA_ID:803,803,Oracle%20Database%20Express%20Edition,Oracle%20Database%20Express%20Edition,1,0&cs=3w8UFYApSKJzp35z9zZdqC8NuOmY8EAHlgdbyW3QipXVzellAZB7ccnU3yOUaz4YDouDlm77Ui0I-P4zxHv_mKQ)
- [Oracle Container Registryを使ってOracle製品をDocker環境で動かしてみる \#oracle - Qiita](https://qiita.com/charon/items/44624e2cdf21449769cf)
- [【Docker】Oracleを無料で簡単にローカルに構築する](https://zenn.dev/re24_1986/articles/29430f2f8b4b46)
