{include file='forms/3_userheader.tpl'}

<p>{gt text='Thank you %s for your reservation.' tag1=$userdata.uname|safehtml}<p/>
<p>{gt text='An email with the filled in data will be sent to our and your email address (%s). We will reply as soon as possible.' tag1=$userdata.uemail|safehtml}</p>
<p>{$sitename}</p>

<hr />

<div style="text-align: center;">
    {gt text='This data was sent to us:'}
    <br /><br />
</div>

<table width="80%">

    <tr>
        <td style="width: 50%; font-weight:bold; text-align:right; padding-right: 50px;">
            {gt text='Your Name'}&nbsp;:
        </td>
        <td style="width: 50%; text-align:left; padding-left: 50px;">
            {$userdata.uname|safehtml}
        </td>
    </tr>

    <tr>
        <td style="width: 50%; font-weight:bold; text-align:right; padding-right: 50px;">
            {gt text='Email'}&nbsp;:
        </td>
        <td style="width: 50%; text-align:left; padding-left: 50px;">
            {$userdata.uemail|safehtml}
        </td>
    </tr>

    {foreach item=field from=$custom}
    <tr>
        <td style="width: 50%; font-weight:bold; text-align:right; padding-right: 50px;">
            {$field.name|safetext}&nbsp;:
        </td>
        <td style="width: 50%; text-align:left; padding-left: 50px;">
            {$field.data|safehtml}
        </td>
    </tr>
    {/foreach}

    <tr>
        <td style="width: 50%; font-weight:bold; text-align:right; padding-right: 50px;">
            {gt text='Comment'}&nbsp;:
        </td>
        <td style="width: 50%; text-align:left; padding-left: 50px;">
            {$userdata.comment|safehtml|nl2br}
        </td>
    </tr>

</table>

<br />
{if $sendtouser==true}
{gt text='Confirmation of your submission will be emailed to you in a few minutes.'}
{else}
{gt text='There was an internal error when sending confirmation mail'}
{/if}

{include file='forms/3_userfooter.tpl'}
