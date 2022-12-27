# to see channels listed in the standard order
Get-WinEvent -ListLog *

# to sort more active channels to the top of the list
# Get-WinEvent -ListLog * | sort RecordCount -Descending
