module Web.View.Sessions.Signup where
import Web.View.Prelude

data SignupView = SignupView { user :: User }

instance View SignupView where
    html SignupView { .. } = [hsx|
        {breadcrumb}
        <h1>New User</h1>
        {renderForm user}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Users" UsersAction
                , breadcrumbText "New User"
                ]

renderForm :: User -> Html
renderForm user = formFor user [hsx|
    {(textField #email)}
    {(textField #passwordHash)}
    {(textField #failedLoginAttempts)}
    {(textField #logins)}
    {submitButton}

|]