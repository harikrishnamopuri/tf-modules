output "bucket" {
  description = "Bucket resource (for single use)."
  value       = google_storage_bucket.buckets[0]
}

output "name" {
  description = "Bucket name (for single use)."
  value       = google_storage_bucket.buckets[0].name
}

output "url" {
  description = "Bucket URL (for single use)."
  value       = google_storage_bucket.buckets[0].url
}

output "buckets" {
  description = "Bucket resources."
  value       = google_storage_bucket.buckets
}

output "names" {
  description = "Bucket names."
  value       = zipmap(var.names, slice(google_storage_bucket.buckets[*].name, 0, length(var.names)))
}

output "urls" {
  description = "Bucket URLs."
  value       = zipmap(var.names, slice(google_storage_bucket.buckets[*].url, 0, length(var.names)))
}

output "names_list" {
  description = "List of bucket names."
  value       = google_storage_bucket.buckets[*].name
}

output "urls_list" {
  description = "List of bucket URLs."
  value       = google_storage_bucket.buckets[*].url
}
