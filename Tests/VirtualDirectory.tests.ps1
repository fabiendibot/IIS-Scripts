Describe "Validate The execution" {
    
    It "Virtual directory created on IIS" {
        (Get-WebVirtualDirectory –Name Repository).PhysicalPath | Should be "C:\Repository"
    }
}