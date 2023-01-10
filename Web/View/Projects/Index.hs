module Web.View.Projects.Index where
import Web.View.Prelude

data IndexView = IndexView { projects :: [Project]  }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewProjectAction} class="btn btn-primary ms-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Project</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach projects renderProject}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Projects" ProjectsAction
                ]

renderProject :: Project -> Html
renderProject project = [hsx|
    <tr>
        <td>{project.name}</td>
        <td><a href={ShowProjectAction project.id}>Show</a></td>
        <td><a href={EditProjectAction project.id} class="text-muted">Edit</a></td>
        <td><a href={DeleteProjectAction project.id} class="js-delete text-muted">Delete</a></td>
    </tr>
|]