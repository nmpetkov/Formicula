{include file='forms/0_userheader.tpl'}

<p class="z-informationmsg">{gt text='Thank you for your questions/comments to our website!<br />We will reply as soon as possible.'}</p>
<form class="z-form" action="{modurl modname=Formicula type=user func=main}" method="post">
    <fieldset>
        <legend>{gt text='This data was sent to %s' tag1=$contact.name|safehtml|default:"&nbsp;"}</legend>

        <div class="z-formrow">
            <label>{gt text='Your Name'}</label>
            <span>{$userdata.uname|safehtml|default:"&nbsp;"}</span>
        </div>

        <div class="z-formrow">
            <label>{gt text='Email'}</label>
            <span>{$userdata.uemail|safehtml|default:"&nbsp;"}</span>
        </div>

        {if $modvars.Formicula.show_company==1}
        <div class="z-formrow">
            <label>{gt text='Company'}</label>
            <span>{$userdata.company|safehtml|default:"-"}</span>
        </div>
        {/if}

        {if $modvars.Formicula.show_url==1}
        <div class="z-formrow">
            <label>{gt text='Homepage'}</label>
            <span>{$userdata.url|safehtml|default:"-"}</span>
        </div>
        {/if}

        {if $modvars.Formicula.show_phone==1}
        <div class="z-formrow">
            <label>{gt text='Phone Number'}</label>
            <span>{$userdata.phone|safehtml|default:"-"}</span>
        </div>
        {/if}

        {if $modvars.Formicula.show_location==1}
        <div class="z-formrow">
            <label>{gt text='Location'}</label>
            <span>{$userdata.location|safehtml|default:"-"}</span>
        </div>
        {/if}

        <div class="z-formrow">
            <label>{gt text='Comment'}</label>
            {if $userformat eq 'html'}
            <div>{$userdata.comment|safehtml|default:"&nbsp;"}</div>
            {else}
            <div>{$userdata.comment|safehtml|nl2br|default:"&nbsp;"}</div>
            {/if}
        </div>

        {if $modvars.Formicula.show_attachfile==1}
        <div class="z-formrow">
            <label>{$custom.fileupload.name}</label>
            <div>{$custom.fileupload.data.name|safehtml|default:"&nbsp;"}</div>
        </div>
        {/if}

    </fieldset>
</form>

<p class="z-sub z-center">
    {if $sendtouser==true}
    {gt text='Confirmation of your submission will be emailed to you in a few minutes.'}
    {else}
    {gt text='There was an internal error when sending confirmation mail'}
    {/if}
</p>

{include file='forms/0_userfooter.tpl'}