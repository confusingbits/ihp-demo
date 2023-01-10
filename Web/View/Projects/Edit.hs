module Web.View.Projects.Edit where
import Web.View.Prelude

data EditView = EditView { project :: Project }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Project</h1>
        {renderForm project}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Projects" ProjectsAction
                , breadcrumbText "Edit Project"
                ]

renderForm :: Project -> Html
renderForm project = formFor project [hsx|
    {(textField #name)}
    {(textField #standupPrompt)}
    {submitButton}

|]