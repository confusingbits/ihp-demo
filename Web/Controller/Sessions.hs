module Web.Controller.Sessions where

import Web.Controller.Prelude
import Web.View.Sessions.New
import Web.View.Sessions.Signup
import qualified IHP.AuthSupport.Controller.Sessions as Sessions

instance Controller SessionsController where
    action NewSessionAction = Sessions.newSessionAction @User
    action CreateSessionAction = Sessions.createSessionAction @User
    action DeleteSessionAction = Sessions.deleteSessionAction @User
    action SignupAction = render SignupView { user = newRecord @User }
    action CreateSignupAction = do
        let user = newRecord @User
        user
            |> fill @["email", "passwordHash"]
            |> validateField #email isEmail
            |> validateField #passwordHash nonEmpty
            |> ifValid \case
                Left user -> render SignupView { .. } 
                Right user -> do
                    hashed <- hashPassword  user.passwordHash
                    user <- user 
                        |> set #passwordHash hashed
                        |> createRecord
                    setSuccessMessage "Signup complete."
                    redirectToPath "/"

instance Sessions.SessionsControllerConfig User where
    beforeLogin = updateLoginHistory

updateLoginHistory user = do
    user
        |> modify #logins (\count -> count + 1)
        |> updateRecord
    pure ()