import os
import subprocess
import lxml.etree as le

#################################################### General ####################################################
def remove_permissions(apk_filename="TrackerControl-githubRelease-latest.apk"):
    """
    Remove permissions from AndroidManifest.xml
    """
    fn = "./"+apk_filename[:-4]+"/AndroidManifest.xml"
    with open(fn,'r') as f:
        doc=le.parse(f)
        for permission in doc.findall('uses-permission'):
            permission.getparent().remove(permission)
        with open(fn, 'wb') as export:
            export.write(le.tostring(doc, pretty_print = True))
            
def remove_adid(apk_filename="TrackerControl-githubRelease-latest.apk"):
    subprocess.run("./patch/_general/remove_adid.sh ./"+str(apk_filename[:-4]), shell=True)
    
def remove_location(apk_filename="TrackerControl-githubRelease-latest.apk"):
    subprocess.run("./patch/_general/remove_location.sh ./"+str(apk_filename[:-4]), shell=True)

###############################################################################################################
    
################################################### Twitter ###################################################
def fix_rebuild_failure(apk_filename="TrackerControl-githubRelease-latest.apk"):
    subprocess.run("./patch/_general/remove_split_apk.sh ./"+str(apk_filename[:-4]), shell=True)
    
def inactivate_notifications_button(apk_filename="TrackerControl-githubRelease-latest.apk"):
    subprocess.run("./patch/com.twitter.android/inactivate_notifications_button.sh ./"+str(apk_filename[:-4]), shell=True)
    
def remove_status_updates(apk_filename="TrackerControl-githubRelease-latest.apk"):
    subprocess.run("./patch/com.twitter.android/remove_status_updates.sh ./"+str(apk_filename[:-4]), shell=True)
    
def remove_unread_notification_count(apk_filename="TrackerControl-githubRelease-latest.apk"):
    subprocess.run("./patch/com.twitter.android/remove_unread_notification_count.sh ./"+str(apk_filename[:-4]), shell=True)
    
###############################################################################################################
