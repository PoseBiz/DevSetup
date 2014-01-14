#!/bin/sh

LBB_PROJECT_ROOT="/home/vagrant/MoonBox/portal"

mysql -u root --password=password -D lbb < $LBB_PROJECT_ROOT/data/sql/schema.sql
mysql -u root --password=password -D lbb -e 'ALTER TABLE user DROP FOREIGN KEY user_latest_bag_id_bag_id;'
mysql -u root --password=password -D lbb -e 'ALTER TABLE friend DROP FOREIGN KEY friend_followee_id_friend_follower_id;'

mysql -u root --password=password -D lbb < $LBB_PROJECT_ROOT/data/sql/category.sql
mysql -u root --password=password -D lbb < $LBB_PROJECT_ROOT/data/sql/charms.sql
mysql -u root --password=password -D lbb < $LBB_PROJECT_ROOT/data/sql/quiz.sql
mysql -u root --password=password -D lbb < $LBB_PROJECT_ROOT/data/sql/bots.sql
mysql -u root --password=password -D lbb < $LBB_PROJECT_ROOT/data/sql/account_cancel_reason.sql
mysql -u root --password=password -D lbb < $LBB_PROJECT_ROOT/data/sql/shipping_type.sql
mysql -u root --password=password -D lbb < $LBB_PROJECT_ROOT/data/sql/tax_rates.sql
mysql -u root --password=password -D lbb < $LBB_PROJECT_ROOT/data/sql/call_center_reasons.sql
mysql -u root --password=password -D lbb < $LBB_PROJECT_ROOT/data/sql/rollover_reasons.sql

mysql -u root --password=password -D lbb < $LBB_PROJECT_ROOT/data/sql/shoes/bkup_*_brand.sql
mysql -u root --password=password -D lbb < $LBB_PROJECT_ROOT/data/sql/shoes/bkup_*_product.sql
