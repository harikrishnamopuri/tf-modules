module "frigga_app" {
  source = "../alias"
  string = replace(var.app_name, "-", "")
}

module "name" {
  source = "../alias"
  string = join(
    "-",
    compact(
      [
        module.frigga_app.string,
      ],
    ),
  )
}

