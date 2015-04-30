#! /bin/csh -f

set NX = $OCN_NX
set NY = $OCN_NY

 #******************************************************************#
 # If the user changes any input datasets - be sure to give it a    #
 # unique filename. Do not duplicate any existing input files       #
 #******************************************************************#

cd $RUNDIR
mkdir -p OUTPUT
mv  archv.* archm.* OUTPUT/
mv *cice.h.*.nc OUTPUT/
rm ovrtn_out 
cp -p -f /glade/p/work/abozec/hycom/HYCOM_CESM/INPUT_h98/* .
set base_filename = "hycom_in"

set inst_counter = 1

while ($inst_counter <= $NINST_OCN)

    set inst_string = " "
    if ($NINST_OCN > 1) then
        set inst_string = $inst_counter
        if ($inst_counter <= 999) set inst_string = 0$inst_string
        if ($inst_counter <=  99) set inst_string = 0$inst_string
        if ($inst_counter <=   9) set inst_string = 0$inst_string
        set inst_string = _$inst_string
    endif

    set in_filename = ${base_filename}${inst_string}

cat >! ${in_filename} << EOF
$NX                  !  i-direction global dimension
$NY                  !  j-direction global dimension
4                    !  decomp_type  1=1d-by-lat, 2=1d-by-lon, 3=2d, 4=2d evensquare, 11=segmented
0                    !  num of pes for i (type 3 only)
0                    !  length of segments (type 4 only)
EOF

    @ inst_counter = $inst_counter + 1

end


