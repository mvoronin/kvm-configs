#!/usr/bin/env bash

SOURCE_LV=/dev/vg_virt/lv_ubuntu_1404

SNAPSHOT_APPSRV_1=/dev/vg_virt/lv_ss1_appsrv_1
SNAPSHOT_DBSRV_1=/dev/vg_virt/lv_ss1_dbsrv_1
SNAPSHOT_WEBSRV_1=/dev/vg_virt/lv_ss1_websrv_1

virsh destroy appsrv-1
virsh destroy dbsrv-1
virsh destroy websrv-1

sudo lvremove -f $SNAPSHOT_APPSRV_1
sudo lvcreate --size 5G --snapshot --name $SNAPSHOT_APPSRV_1 $SOURCE_LV

sudo lvremove -f $SNAPSHOT_DBSRV_1
sudo lvcreate --size 5G --snapshot --name $SNAPSHOT_DBSRV_1  $SOURCE_LV

sudo lvremove -f $SNAPSHOT_WEBSRV_1
sudo lvcreate --size 3G --snapshot --name $SNAPSHOT_WEBSRV_1 $SOURCE_LV

virsh create configs/appsrv-1.xml
virsh create configs/dbsrv-1.xml
virsh create configs/websrv-1.xml
