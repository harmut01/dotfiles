function aoc
    set -q day; or set day (date +'%d' | sed 's/^0//')
    set year (date +'%Y')

    set file day$day.py
    cp template $file

    sed -i '' "s/{day}/"$day"/" $file
    sed -i '' "s/{year}/"$year"/" $file
end
