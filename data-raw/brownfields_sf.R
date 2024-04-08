# used arcgis query builder
lrp_read <- sf::st_read("https://mdewin64.mde.state.md.us/arcgis/rest/services/MDE_LRP/LandRestorationProgram/MapServer/0/query?where=State+%3D+%27Maryland%27&text=&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&relationParam=&outFields=*&returnGeometry=true&returnTrueCurves=false&maxAllowableOffset=&geometryPrecision=&outSR=&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&resultOffset=&resultRecordCount=&f=geojson")

lrp_sf <- janitor::clean_names(lrp_read)
lrp_sf <- dplyr::select(lrp_sf, id = objectid_1, name = site_name, address, city,
                        is_brownfield = brownfield, is_npl = npl, is_ongoing_assess = assess_ongo, is_ongoing_remed = remed_ongo, is_archived = archived,
                        fy_open, fy_closed)
lrp_sf <- dplyr::mutate(lrp_sf, dplyr::across(c(fy_open, fy_closed), as.numeric))
lrp_sf <- dplyr::mutate(lrp_sf, dplyr::across(c(is_brownfield, is_npl, is_ongoing_assess, is_ongoing_remed, is_archived), \(x) x == "Yes"))

# single column of brownfield, npl, or both (only 1)
brownfields_sf <- dplyr::filter(lrp_sf, is_brownfield | is_npl)
brownfields_sf <- tidyr::pivot_longer(brownfields_sf, cols = is_brownfield:is_npl, names_to = c(NA, "site_type"), names_sep = "_")
brownfields_sf <- dplyr::filter(brownfields_sf, value)
brownfields_sf <- dplyr::group_by(brownfields_sf, dplyr::across(id:fy_closed))
brownfields_sf <- dplyr::summarise(brownfields_sf, site_type = toString(site_type))
brownfields_sf <- dplyr::ungroup(brownfields_sf)
brownfields_sf$site_type <- forcats::fct_recode(as.factor(brownfields_sf$site_type), "both" = "brownfield, npl")


usethis::use_data(brownfields_sf, overwrite = TRUE)



