{include file='forms/2_userheader.tpl'}

{pageaddvar name="javascript" value="jquery"}
{pageaddvar name='javascript' value='modules/Formicula/javascript/js-webshim/minified/extras/modernizr-custom.js'}
{pageaddvar name='javascript' value='modules/Formicula/javascript/js-webshim/minified/polyfiller.js'}

<form id="contactform" action="{modurl modname=Formicula type=user func=send}" method="post">
    <div>
        <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
        <input type="hidden" name="form" value="2" />
        <input type="hidden" name="formname" value="Example more elaborate contact form" />
        <input type="hidden" name="adminformat" value="{$modvars.Formicula.default_adminformat}" />
        {if $modvars.Formicula.show_userformat!=1}<input type="hidden" name="userformat" value="{$modvars.Formicula.default_userformat}" />{/if}
        <input type="hidden" name="dataformat" value="array" />

        <p>
            {gt text="Mandatory fields are indicated with a"}<span class="mandatory">*</span>
        </p>

        <p>
            <label for="cid">{gt text="Contact or Theme"}&nbsp;:</label><br />
            <select class="formborder" id="cid" name="cid">
                {foreach item=contact from=$contacts}
                {if $contact.public == "1"}
                <option value="{$contact.cid}">{$contact.name}</option>
                {/if}
                {/foreach}
            </select>
        </p>

        <p>
            <label for="uname">{gt text="Your Name"}&nbsp;:<span class="mandatory">*</span></label><br />
            <input type="text" required class="formborder" id="uname" name="userdata[uname]" size="40" maxlength="80" value="{$userdata.uname}" />
        </p>

        <p>
            <label for="uemail">{gt text="Email"}&nbsp;:<span class="mandatory">*</span></label><br />
            <input type="email" required placeholder="{gt text='Enter a valid email address'}" class="formborder" id="uemail" name="userdata[uemail]" size="40" maxlength="40" value="{$userdata.uemail}" />
        </p>

        {if $modvars.Formicula.show_url==1}
        <p>
            <label for="url">{gt text="Homepage"}&nbsp;:</label><br />
            <input type="url" placeholder="http://" class="formborder" id="url" name="userdata[url]" size="40" maxlength="40" value="{$userdata.url}" />
        </p>
        {/if}

        {if $modvars.Formicula.show_phone==1}
        <p>
            <label for="phone">{gt text="Phone Number"}&nbsp;:</label><br />
            <input type="text" class="formborder" id="phone" name="userdata[phone]" size="40" maxlength="40" value="{$userdata.phone}" />
        </p>
        {/if}

        {if $modvars.Formicula.show_company==1}
        <p>
            <label for="company">{gt text="Company"}&nbsp;:</label><br />
            <input type="text" class="formborder" id="company" name="userdata[company]" size="40" maxlength="40" value="{$userdata.company}" />
        </p>
        {/if}

        {if $modvars.Formicula.show_location==1}
        <p>
            <label for="location">{gt text="Location"}&nbsp;:</label><br />
            <input type="text" class="formborder" id="location" name="userdata[location]" size="40" maxlength="40" value="{$userdata.location}" />
        </p>
        {/if}

        <p>
            <label for="comment">{gt text="Comment"}&nbsp;:<span class="mandatory">*</span></label><br />
            <textarea required placeholder="{gt text='Your comments here...'}" class="formborder required" rows="6" cols="45" id="comment" name="userdata[comment]">{$userdata.comment}</textarea>
        </p>

        {if $modvars.Formicula.show_userformat==1}
        <p>
            <label for="userformat">{gt text="Email Format"}&nbsp;:</label><br />
            <select class="formborder" id="userformat" name="userformat">
                <option value="html"{if $modvars.Formicula.default_userformat eq 'html'} selected="selected"{/if}>{gt text="HTML"}</option>
                <option value="plain"{if $modvars.Formicula.default_userformat eq 'plain'} selected="selected"{/if}>{gt text="Text"}</option>
            </select>
        </p>
        {/if}

        {if $spamcheck eq 1}
        <p>
            <label for="formicula_captcha">{gt text='Please solve this calculation'} :<span class="mandatory">*</span></label>
            &nbsp;{simplecaptcha font='quikhand' size='14' bgcolor='ffffff' fgcolor='000000'} 
            <input id="formicula_captcha" name="captcha" type="text" size="5" maxlength="5" value="" />
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