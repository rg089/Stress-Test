Write-Host "Beginning Stress Tests..." -ForegroundColor Yellow -BackgroundColor Black
g++ code.cpp -o original
g++ gen.cpp -o generator
g++ brute.cpp -o brute
$i = 0;
$flag = 1;
while ($true){
    $i++
    .\generator $i > input_stress.txt
    Get-Content input_stress.txt | .\original > original_output.txt
    Get-Content input_stress.txt | .\brute > brute_output.txt
    if (Compare-Object -ReferenceObject ((get-content .\original_output.txt).trim()) -DifferenceObject ((Get-Content .\brute_output.txt).trim())){
        Write-Host "Test ${i}: " -ForegroundColor White -BackgroundColor Black -NoNewline
        Write-Host "Failed" -ForegroundColor: Black -BackgroundColor: Red
        $flag = 0;
        break;
        } 
    else{
        Write-Host "Test ${i}: " -ForegroundColor White -BackgroundColor Black -NoNewline
        Write-Host "Passed" -ForegroundColor: Green -BackgroundColor: Black
        }
}

if ($flag -eq 0){
    Write-Host "Input" -ForegroundColor Yellow -BackgroundColor Black
    Get-Content .\input_stress.txt
    Write-Host ""
    Write-Host "Correct Output" -ForegroundColor Black -BackgroundColor Green
    Get-Content .\brute_output.txt
    Write-Host ""
    Write-Host "Generated Output" -ForegroundColor Red -BackgroundColor Black
    Get-Content .\original_output.txt
    Write-Host ""
}
