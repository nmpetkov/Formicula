<?php
/**
 * Formicula - the contact mailer for Zikula
 * -----------------------------------------
 *
 * @copyright  (c) Formicula Development Team
 * @link       http://code.zikula.org/formicula
 * @license    GNU/GPL - http://www.gnu.org/copyleft/gpl.html
 * @author     Frank Schummertz <frank@zikula.org>
 * @package    Third_Party_Components
 * @subpackage formicula
 */

class Formicula_Form_Handler_Admin_Edit extends Zikula_Form_AbstractHandler
{
    public $cid;

    function initialize(Zikula_Form_View $view)
    {
        $this->cid = (int)FormUtil::getPassedValue('cid', -1, 'GETPOST');

        $view->caching = false;
        $view->add_core_data();

        if(($this->cid==-1) ) {
            $mode = 'create';
            $contact = array('cid'      => -1,
                             'name'     => '',
                             'email'    => '',
                             'public'   => 1,
                             'semail'   => '',
                             'sname'    => '',
                             'ssubject' => '');
        } else {
            $mode = 'edit';
            $contact = ModUtil::apiFunc('Formicula', 'Admin', 'getContact',
                                        array('cid' => $this->cid));
            if ($contact == false) {
                return LogUtil::registerError($this->__('Unknown Contact'), null, ModUtil::url('Formicula', 'admin', 'main'));
            }
        }

        $view->assign('mode', $mode);
        $view->assign('contact', $contact);

        return true;
    }


    function handleCommand(Zikula_Form_View $view, &$args)
    {
        // Security check
        if (!SecurityUtil::checkPermission('Formicula::', '::', ACCESS_ADMIN)) {
            return LogUtil::registerPermissionError(ModUtil::url('Formicula', 'admin', 'main'));
        }
        if ($args['commandName'] == 'submit') {
            $ok = $view->isValid();

            $data = $view->getValues();
            $data['cid'] = $this->cid;
            $data['public'] = (int)$data['public'];

            // copy cname to name for updating the db
            $data['name'] = $data['cname'];

            // no deletion, further checks needed
            if(empty($data['cname'])) {
                $ifield = & $view->getPluginById('cname');
                $ifield->setError(DataUtil::formatForDisplay($this->__('Error! No contact name')));
                $ok = false;
            }
            if(empty($data['email']) || !System::varValidate($data['email'], 'email')) {
                $ifield = & $view->getPluginById('email');
                $ifield->setError(DataUtil::formatForDisplay($this->__('Error! No or incorrect email address supplied')));
                $ok = false;
            }
            if(!empty($data['semail']) && !System::varValidate($data['semail'], 'email')) {
                $ifield = & $view->getPluginById('semail');
                $ifield->setError(DataUtil::formatForDisplay($this->__('Error! Incorrect email address supplied')));
                $ok = false;
            }

            if(!$ok) {
                return false;
            }

            // The API function is called
            if($data['cid'] == -1) {
                if(ModUtil::apiFunc('Formicula', 'Admin', 'createContact', $data) <> false) {
                    // Success
                    LogUtil::registerStatus($this->__('Contact created'));
                } else {
                    LogUtil::registerError($this->__('Error creating contact!'));
                }
            } else {
                if(ModUtil::apiFunc('Formicula', 'Admin', 'updateContact', $data) <> false) {
                    // Success
                    LogUtil::registerStatus($this->__('Contact info has been updated'));
                } else {
                    LogUtil::registerError($this->__('Error updating contact!'));
                }
            }

        }
        return System::redirect(ModUtil::url('Formicula', 'admin', 'main'));
    }

}
