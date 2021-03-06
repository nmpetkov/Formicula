{include file='forms/1_userheader.tpl'}

{pageaddvar name="javascript" value="jquery"}
{pageaddvar name='javascript' value='modules/Formicula/javascript/js-webshim/minified/extras/modernizr-custom.js'}
{pageaddvar name='javascript' value='modules/Formicula/javascript/js-webshim/minified/polyfiller.js'}

<form id="contactform" action="{modurl modname=Formicula type=user func=send}" method="post">
<div>
<input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
<input type="hidden" name="form" value="1" />
<input type="hidden" name="formname" value="Example job application form" />
<input type="hidden" name="adminformat" value="{$modvars.Formicula.default_adminformat}" />
<input type="hidden" name="userformat" value="{$modvars.Formicula.default_userformat}" />
<input type="hidden" name="numFields" value="7" />
<input type="hidden" name="cid" value="1" />
<input type="hidden" name="dataformat" value="array" />

<p>
    {gt text="Mandatory fields are indicated with a"}<span class="mandatory">*</span>
</p>

<p>
    <label for="apply_as">{gt text='Apply as'}<span class="mandatory">*</span></label><br />
    <input type="hidden" name="custom[apply_as][name]" value="{gt text='Apply as'}" />
    <input type="hidden" name="custom[apply_as][mandatory]" value="1" />
    <input type="text" required class="formborder" name="custom[apply_as][data]" id="apply_as" size="35" maxlength="80" value="{$custom.apply_as.data}" />
</p>

<p style="clear: left;">
    <span style="float:left; width: 49%;">
        <label for="uname">{gt text='Your Name'}<span class="mandatory">*</span></label><br />
        <input type="text" required class="formborder" name="userdata[uname]" id="uname" size="35" maxlength="80" value="{$userdata.uname}" />
    </span>
    <span style="float:left; width: 49%;">
        <label for="dateofbirth">{gt text='Date of birth'}<span class="mandatory">*</span></label><br />
        <input type="hidden" name="custom[dateofbirth][name]" value="{gt text='Date of birth'}" />
        <input type="hidden" name="custom[dateofbirth][mandatory]" value="1" />
        <input type="text" required pattern="{literal}\d{1,2}[/-]\d{1,2}[/-](?:\d{4}|\d{2}){/literal}" title="{gt text='Please enter a valid date (mm/dd/yyyy).'}" class="formborder" name="custom[dateofbirth][data]" id="dateofbirth" size="35" maxlength="40" value="{$custom.dateofbirth.data}" />
    </span>
</p>

<p style="clear: left;">
    <span style="float:left; width: 49%;">
        <label for="street">{gt text='Street'}<span class="mandatory">*</span></label><br />
        <input type="hidden" name="custom[street][name]" value="{gt text='Street'}" />
        <input type="hidden" name="custom[street][mandatory]" value="1" />
        <input type="text" required class="formborder" name="custom[street][data]" id="street" size="35" maxlength="40" value="{$custom.street.data}" />
    </span>
    <span style="float:left; width: 49%;">
        <label for="salary">{gt text='Salary'}<span class="mandatory">*</span></label><br />
        <input type="hidden" name="custom[salary][name]" value="{gt text='Salary'}" />
        <input type="hidden" name="custom[salary][mandatory]" value="1" />
        <input type="number" required class="formborder" name="custom[salary][data]" id="salary" size="35" maxlength="40" value="{$custom.salary.data}" />
    </span>
</p>

<p style="clear: left;">
    <span style="float:left; width: 49%;">
        <label for="zipcity">{gt text='Zip City'}<span class="mandatory">*</span></label><br />
        <input type="hidden" name="custom[zipcity][name]" value="{gt text='Zip City'}" />
        <input type="hidden" name="custom[zipcity][mandatory]" value="1" />
        <input type="text" required class="formborder" name="custom[zipcity][data]" id="zipcity" size="35" maxlength="40" value="{$custom.zipcity.data}" />
    </span>
    <span style="float:left; width: 49%;">
        <label for="entrydate">{gt text='Entry date'}<span class="mandatory">*</span></label><br />
        <input type="hidden" name="custom[entrydate][name]" value="{gt text='Entry date'}" />
        <input type="hidden" name="custom[entrydate][mandatory]" value="1" />
        <input type="text" required pattern="{literal}\d{1,2}[/-]\d{1,2}[/-]\d{4}{/literal}" class="formborder" name="custom[entrydate][data]" id="entrydate" size="35" maxlength="40" value="{$custom.entrydate.data}" />
    </span>
</p>

<p style="clear: left;">
    <span style="float:left; width: 49%;">
        <label for="phonenr">{gt text='Phone Number'}<span class="mandatory">*</span></label><br />
        <input type="hidden" name="custom[phonenr][name]" value="{gt text='Phone Number'}" />
        <input type="hidden" name="custom[phonenr][mandatory]" value="1" />
        <input type="text" required class="formborder" name="custom[phonenr][data]" id="phonenr" size="35" maxlength="40" value="{$custom.phonenr.data}" />
    </span>
    <span style="float:left; width: 49%;">
        <label for="url">{gt text='Homepage'}</label><br />
        <input type='url' placeholder="http://" class="formborder" name="userdata[url]" id="url" value="{$userdata.url}" size="35" maxlength="40" />
    </span>
</p>

<p style="clear: left; width: 49%;">
    <label for="uemail">{gt text='Email'}<span class="mandatory">*</span></label><br />
    <input type="email" required placeholder="{gt text='Enter a valid email address'}" class="formborder" name="userdata[uemail]" id="uemail" value="{$userdata.uemail}" size="35" maxlength="40" />
</p>

<p style="clear: left;">
    <label for="comment">{gt text='Comment'}<span class="mandatory">*</span></label><br />
    <textarea required placeholder="{gt text='Your comments here...'}" class="formborder" rows="10" cols="45" name="userdata[comment]" id="comment">{$userdata.comment}</textarea>
</p>

{if $spamcheck eq 1}
<p>
    <label for="formicula_captcha">{gt text='Please solve this calculation'}<span class="mandatory">*</span></label>
    &nbsp;{simplecaptcha font='quikhand' size='14' bgcolor='ffffff' fgcolor='000000'} <input id="formicula_captcha" name="captcha" type="text" size="5" maxlength="5" value="" />
    <span class="z-sub">{gt text='(to prevent spam)'}</span>
</p>
{/if}

{notifydisplayhooks eventname='formicula.ui_hooks.forms.form_edit' id=null}

<p class="z-buttons">
    <input class="z-bt-ok" type="submit" name="submit" value="{gt text="Send"}" />
</p>

<script type="text/javascript">
    // call webshims polyfill to get html5 forms validation and other effects into non-html5 browsers
    jQuery.webshims.activeLang('{{lang}}');
    jQuery.webshims.polyfill('forms');
</script>

</div>
</form>