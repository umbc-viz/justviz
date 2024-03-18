#!/usr/bin/env bash
filedir="data-raw/files"

stateurl="https://gaftp.epa.gov/EJScreen/2023/2.22_September_UseMe/EJSCREEN_2023_Tracts_StatePct_with_AS_CNMI_GU_VI.csv.zip"
statecsv="ejscreen_md_state.csv"
statezip="$statecsv.zip"

natlurl="https://gaftp.epa.gov/EJScreen/2023/2.22_September_UseMe/EJSCREEN_2023_Tracts_with_AS_CNMI_GU_VI.csv.zip"
natlcsv="ejscreen_md_natl.csv"
natlzip="$natlcsv.zip"

# define a function getmd
getmd() {
  url=$1
  zipfile=$2
  csvfile=$3
  curl -L $url -o "$filedir/$zipfile"
  unzip -p "$filedir/$zipfile" | \
  csvsql --tables "ejscreen" --no-inference --query "
    SELECT ID, ACSTOTPOP, DEMOGIDX_2, DEMOGIDX_5, 
      P_PM25, P_D2_PM25, P_D5_PM25,
      P_OZONE, P_D2_OZONE, P_D5_OZONE,
      P_DSLPM, P_D2_DSLPM, P_D5_DSLPM,
      P_CANCER, P_D2_CANCER, P_D5_CANCER,
      P_RESP, P_D2_RESP, P_D5_RESP,
      P_RSEI_AIR AS P_RSEIAIR, P_D2_RSEI_AIR AS P_D2_RSEIAIR, P_D5_RSEI_AIR AS P_D5_RSEIAIR,
      P_PTRAF, P_D2_PTRAF, P_D5_PTRAF,
      P_LDPNT, P_D2_LDPNT, P_D5_LDPNT,
      P_PNPL, P_D2_PNPL, P_D5_PNPL,
      P_PRMP, P_D2_PRMP, P_D5_PRMP,
      P_PTSDF, P_D2_PTSDF, P_D5_PTSDF,
      P_UST, P_D2_UST, P_D5_UST,
      P_PWDIS, P_D2_PWDIS, P_D5_PWDIS
    FROM ejscreen
    WHERE ST_ABBREV = 'MD'" > "$filedir/$csvfile"
  rm "$filedir/$zipfile"
}

getmd $stateurl $statezip $statecsv
getmd $natlurl $natlzip $natlcsv