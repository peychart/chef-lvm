# chef-lvm-cookbook

 This chef cookbook manages the lvm ressources.

## Supported Platforms

 ubuntu/debian

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['lvm_volume_group']</tt></td>
    <td>Hash array</td>
    <td>Volume_groups definitions</td>
    <td><tt>[{}]</tt></td>
  </tr>
</table>

## Usage

 Data_bag "clusters" example:

    {
      "id": "fqdn",
      "lvm_volume_group": [{
        "name": "vg00",
        "physical_volumes": [
          "/dev/sdb"
        ],
        "logical_volume": [{
          "name": "test1",
          "size": "1G",
          "filesystem": "ext4",
          "mount_point": {
            "location": "/media/test1",
            "options": "noatime,nodiratime"
          }
         },{
          "name": "test2",
          "size": "1G",
          "filesystem": "ext4",
          "mount_point": {
            "location": "/media/test2"
          }
        }]
      }]
    }

 Vagranfile example:

    ...
    chef.json = {
      "chef-nodeAttributes" => {
        "databag_name" => "clusters",
        "mergeMode" => false
      }
    }

    chef.run_list = [
      "recipe[chef-nodeAttributes::default]",
      "recipe[chef-lvm::default]"
    ]
    ...

### chef-lvm::default

Include `chef-lvm` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[chef-lvm::default]"
  ]
}
```

## License and Authors

Author:: PE, pf. (<philippe.eychart@mail.pf>)
