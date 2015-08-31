$tempFileName = ".\turnIn"					#
$fileExists = Test-Path $tempFileName		#creates turnIn if it doesn't excists
if($fileExists -ne $True) {mkdir turnIn} 	#

$noCpp = (get-childitem -path . -name *.cpp -exclude turnIn -recurse | ?{ $_.fullname -notmatch "\\obj\\?" }).count
$noFolder = (get-childitem -path . -dir).count

# write $noCpp

$location = get-location

ForEach ($n in 0..$noFolder) {
	$tempName = get-childitem -name -dir -exclude turnIn | ?{$_.fullname -notmatch "\\obj\\?"} | select-object -index $n #must have other files in dir
	cd $tempName
	$tempFullLocation = write $location"\turnIn\"$tempName".cpp"
	if(test-path $tempFullLocation -eq $true)
	{
		$tempFullLocation = write $location"\turnIn\"$tempName$n".cpp"
	}
	
		
	copy-item *.cpp  ..
	#write $tempName
	cd ..
	
		#move-item .\*.cpp  .\turnIn\$tempFullName
	move-item .\*.cpp $tempFullLocation
}


