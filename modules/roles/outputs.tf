output "user_names" {
  value = keys(local.users)
  sensitive = false
}

output "user_passwords" {
  value = {
    for user, data in google_sql_user.users : user => random_password.user_passwords[user].result
  }
  sensitive = false
}
