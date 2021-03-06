{include file='forms/2_userheader.tpl'}

<p class="z-center">
    {gt text='Thank you for your questions/comments to our website!<br />We will reply as soon as possible.'}
    <br /><br />
    {gt text='This data was sent to us:'}
</p>

<table width="80%">
    <tr>
        <td style="width: 50%; font-weight:bold; text-align:right; padding-right: 50px;">
            {gt text='Contact or Theme'}
        </td>
        <td style="width: 50%; text-align:left; padding-left: 50px;">
            {$contact.name|safehtml}
        </td>
    </tr>

    <tr>
        <td style="width: 50%; font-weight:bold; text-align:right; padding-right: 50px;">
            {gt text='Your Name'}
        </td>
        <td style="width: 50%; text-align:left; padding-left: 50px;">
            {$userdata.uname|safehtml}
        </td>
    </tr>

    {if $modvars.Formicula.show_company==1}
    <tr>
        <td style="width: 50%; font-weight:bold; text-align:right; padding-right: 50px;">
            {gt text='Company'}
        </td>
        <td style="width: 50%; text-align:left; padding-left: 50px;">
            {$userdata.company|safehtml}
        </td>
    </tr>
    {/if}

    <tr>
        <td style="width: 50%; font-weight:bold; text-align:right; padding-right: 50px;">
            {gt text='Email'}
        </td>
        <td style="width: 50%; text-align:left; padding-left: 50px;">
            {$userdata.uemail|safehtml}
        </td>
    </tr>

    {if $modvars.Formicula.show_url==1}
    <tr>
        <td style="width: 50%; font-weight:bold; text-align:right; padding-right: 50px;">
            {gt text='Homepage'}
        </td>
        <td style="width: 50%; text-align:left; padding-left: 50px;">
            {$userdata.url|safehtml}
        </td>
    </tr>
    {/if}

    {if $modvars.Formicula.show_phone==1}
    <tr>
        <td style="width: 50%; font-weight:bold; text-align:right; padding-right: 50px;">
            {gt text='Phone Number'}
        </td>
        <td style="width: 50%; text-align:left; padding-left: 50px;">
            {$userdata.phone|safehtml}
        </td>
    </tr>
    {/if}

    {if $modvars.Formicula.show_location==1}
    <tr>
        <td style="width: 50%; font-weight:bold; text-align:right; padding-right: 50px;">
            {gt text='Location'}
        </td>
        <td style="width: 50%; text-align:left; padding-left: 50px;">
            {$userdata.location|safehtml}
        </td>
    </tr>
    {/if}

    <tr>
        <td style="width: 50%; font-weight:bold; text-align:right; padding-right: 50px;">
            {gt text='Comment'}
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

{include file='forms/2_userfooter.tpl'}
