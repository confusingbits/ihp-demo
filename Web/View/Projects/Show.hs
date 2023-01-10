module Web.View.Projects.Show where
import Web.View.Prelude

data ShowView = ShowView { project :: Project }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>{project.name}</h1>
        <p>{project.standupPrompt}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Projects" ProjectsAction
                            , breadcrumbText "Show Project"
                            ]