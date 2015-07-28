function Resize-Partitions
{
    $disks = Get-Disk
    Foreach($disk in $disks)
    {
        $partitions = Get-Partition $disk.Number
        Foreach($partition in $partitions)
        {
            $size = Get-PartitionSupportedSize -DiskNumber $disk.Number -PartitionNumber $partition.PartitionNumber
            Resize-Partition -Disknumber $disk -PartitionNumber $partition.PartitionNumber -Size $size.SizeMax
        }
    }
}