<?php
/**
 * Formicula - the contact mailer for Zikula
 * -----------------------------------------
 *
 * @copyright  (c) Formicula Development Team
 * @link       http://code.zikula.org/formicula 
 * @version    $Id$
 * @license    GNU/GPL - http://www.gnu.org/copyleft/gpl.html
 * @author     Frank Schummertz <frank@zikula.org>
 * @package    Third_Party_Components
 * @subpackage formicula
 */
 
Loader::requireOnce('includes/FileUtil.class.php');
Loader::requireOnce('includes/StringUtil.class.php');

function formicula_init()
{
    $tempdir = pnConfigGetVar('temp');
    if(StringUtil::left($tempdir, 1) <> '/') {
        // tempdir does not start with a / which means it does not reside outside
        // the webroot, continue
        if(StringUtil::right($tempdir, 1) <> '/') {
            $tempdir .= '/';
        }
        if(FileUtil::mkdirs($tempdir . 'formicula_cache')) {
            $res1 = FileUtil::writeFile($tempdir . 'formicula_cache/index.html');
            $res2 = FileUtil::writeFile($tempdir . 'formicula_cache/.htaccess', 'SetEnvIf Request_URI "\.gif$" object_is_gif=gif
SetEnvIf Request_URI "\.png$" object_is_png=png
SetEnvIf Request_URI "\.jpg$" object_is_jpg=jpg
Order deny,allow
Deny from all
Allow from env=object_is_gif
Allow from env=object_is_png
Allow from env=object_is_jpg
');
            if($res1===false || $res2===false){
                LogUtil::registerStatus(_FOR_CREATEFILESFAILED);
            }
        } else {
            LogUtil::registerStatus(_FOR_CREATEFOLDERFAILED);
        }
    } else {
        // tempdir starts with /, so it is an absolute path, probably outside the webroot
        LogUtil::registerStatus(_FOR_CANNOTCREATEFOLDEROUTSIDEWEBROOT);
    }
    
    // create the formicula table
    if (!DBUtil::createTable('formcontacts')) {
        return LogUtil::registerError(_FOR_CREATETABLEFAILED);
    }

    pnModAPILoad('formicula', 'admin', true);
    pnModAPIFunc('formicula',
                 'admin',
                 'createContact',
                 array('name'     => 'Webmaster',
                       'email'    => pnConfigGetVar('adminmail'),
                       'public'   => 1,
                       'sname'    => 'Webmaster',
                       'semail'   => pnConfigGetVar('adminmail'),
                       'ssubject' => _FOR_EMAILFROM . ' %s'));

    pnModSetVar('formicula', 'show_phone', 1);
    pnModSetVar('formicula', 'show_company', 1);
    pnModSetVar('formicula', 'show_url', 1);
    pnModSetVar('formicula', 'show_location', 1);
    pnModSetVar('formicula', 'show_comment', 1);
    pnModSetVar('formicula', 'send_user', 1);
    pnModSetVar('formicula', 'spamcheck', 1);

    pnModSetVar('formicula', 'upload_dir', 'pnTemp');
    pnModSetVar('formicula', 'delete_file', 1);

    pnModSetVar('formicula', 'default_form', 0);

    // Initialisation successful
    return true;
}


function formicula_upgrade($oldversion)
{
    // Get database information
    pnModDBInfoLoad('formicula');

    // perform a global db change for all versions >= 0.4
    if(version_compare($oldversion, '0.5', '>')) { 
        if (!DBUtil::changeTable('formcontacts')) {
            return LogUtil::registerError(_FOR_DBUPGRADEFAILED);
        }
    }

    // Upgrade dependent on old version number
    switch($oldversion) {
        case '0.1':
            pnModSetVar('formicula', 'upload_dir', 'pnTemp');
            pnModSetVar('formicula', 'delete_file', 1);
        case '0.2':
            // nothing to do
        case '0.3':
            // nothing to do
        case '0.4':
            // create the formicula table
            if (!DBUtil::createTable('formcontacts')) {
                return LogUtil::registerError(_FOR_CREATETABLEFAILED);
            }

            // migrate contacts from config var to table
            $contacts = pnModGetVar('formicula', 'contacts');
            if( @unserialize( $contacts ) != "" ) {
                $contacts_array = unserialize( $contacts );
            } else {
                $contacts_array = array();
            }
            foreach ($contacts_array as $contact) {
                $name  = pnVarPrepForStore($contact['name']);
                $email = pnVarPrepForStore($contact['email']);
                pnModAPIFunc('formicula',
                             'admin',
                             'createContact',
                             array('name'     => $name,
                                   'email'    => $email,
                                   'public'   => 1,
                                   'sname'    => '',   
                                   'semail'   => '',
                                   'ssubject' => ''));
            }
            pnModDelVar('formicula', 'contacts'); 
            pnModDelVar('formicula', 'version' );
        case '0.5':
                // nothing to do
        case '0.6':
            // the db change has been already
            pnModSetVar('formicula', 'spamcheck', 1);
            pnModSetVar('formicula', 'excludespamcheck', '');
        case '1.0':
            // nothing to do
        case '1.1':

            $tempdir = pnConfigGetVar('temp');
            if(StringUtil::right($tempdir, 1) <> '/') {
                $tempdir .= '/';
            }
            if(!is_dir($tempdir . 'formicula_cache')) {
                if(FileUtil::mkdirs($tempdir . 'formicula_cache')) {
                    $res1 = FileUtil::writeFile($tempdir . 'formicula_cache/index.html');
                    $res2 = FileUtil::writeFile($tempdir . 'formicula_cache/.htaccess', 'SetEnvIf Request_URI "\.gif$" object_is_gif=gif
SetEnvIf Request_URI "\.png$" object_is_png=png
SetEnvIf Request_URI "\.jpg$" object_is_jpg=jpg
Order deny,allow
Deny from all
Allow from env=object_is_gif
Allow from env=object_is_png
Allow from env=object_is_jpg
');
                    if($res1===false || $res2===false){
                        LogUtil::registerStatus(_FOR_CREATEFILESFAILED);
                    }
                } else {
                    LogUtil::registerStatus(_FOR_CREATEFOLDERFAILED);
                }
            }
        case '2.0':
            // set the default form
            pnModSetVar('formicula', 'default_form', 0);

    }

    // clear compiled templates
    pnModAPIFunc('pnRender', 'user', 'clear_compiled');

    // Update successful
    return true;
}


function formicula_delete()
{
    // drop the table
    if (!DBUtil::dropTable('formcontacts')) {
        return LogUtil::registerError(_FOR_DROPTABLEFAILED);
    }

    $tempdir = pnConfigGetVar('temp');
    if(StringUtil::right($tempdir, 1) <> '/') {
        $tempdir .= '/';
    }
    if(is_dir($tempdir . 'formicula_cache')) {
        FileUtil::deldir($tempdir . 'formicula_cache');
    }
    
    // Remove module variables
    pnModDelVar('formicula');

    return true;
}