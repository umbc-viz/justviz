#!/usr/bin/env bash
filedir="data-raw/files/ej_trend"
db="data-raw/files/ej_trend.duckdb"

declare -A urls
# urls["2017"]="https://gaftp.epa.gov/EJScreen/2017/EJSCREEN_2017_USPR_Public.csv"
urls["2018"]="https://gaftp.epa.gov/EJScreen/2018/EJSCREEN_2018_USPR_csv.zip"
urls["2019"]="https://gaftp.epa.gov/EJScreen/2019/EJSCREEN_2019_USPR.csv.zip"
urls["2020"]="https://gaftp.epa.gov/EJScreen/2020/EJSCREEN_2020_USPR.csv.zip"
urls["2021"]="https://gaftp.epa.gov/EJScreen/2021/EJSCREEN_2021_USPR.csv.zip"
urls["2022"]="https://gaftp.epa.gov/EJScreen/2022/EJSCREEN_2022_with_AS_CNMI_GU_VI.csv.zip"
urls["2023"]="https://gaftp.epa.gov/EJScreen/2023/2.22_September_UseMe/EJSCREEN_2023_BG_with_AS_CNMI_GU_VI.csv.zip"

# iterate over keys
for year in "${!urls[@]}"; do
    url=${urls[$year]}
    zipfn="ejscreen_${year}.csv.zip"
    zippath="$filedir/$zipfn"
    csvfn="ej_${year}.csv"
    # csvpath="$filedir/$csvfn"

    tbl="ej_${year}"

    if ! [ -f "$zippath" ]; then
        curl -L $url -o "$zippath"
    fi

    unzip -j -u "$zippath" "*.csv" -d "$filedir"
    csvpath=$(find "$filedir" -name "*$year*.csv")
    

    duckdb -c "CREATE TABLE IF NOT EXISTS $tbl AS
              SELECT * FROM read_csv('$csvpath')
              WHERE ST_ABBREV = 'MD';" $db

    echo "Year $year written to $db"
done

# check
duckdb -c "SELECT * FROM information_schema.tables;" $db
