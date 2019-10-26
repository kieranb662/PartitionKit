# Partition Kit

What is PartitionKit? 
- It is the solution to the need for composable and dynamically sized user interface content in SwiftUI. 
- also the first piece of software I have ever made into a library so please be gentle(both with use cases and with my heart).

What is **not** PartitionKit?
- PartitionKit is not a means to work with an form of stored data, this is not for partitioning hard drives or any other type of formattable data drive. 


## Requirements 

PartitionKit as a default requires the SwiftUI Framework to be operational, as such only these platforms are supported:

*  macOS 10.15 or Greater 
* iOS 13 or Greater 
* tvOS 13 or Greater 
* watchOS 6 or Greater 


## How To Add To You Project

1. Snag that URL from the github repo 
2. In Xcode -> File -> Swift Packages -> Add Package Dependencies 
3.  Paste the URL Into the box
4. Specify the minimum version number (This is new so 0.0.0 and greater will work).


## How To Use 


### Vertical Partition 

1. Decide on what view you would like to have on `Top`, which you would like to have on the `Bottom` and optionally a `Handle` to be used to drag the partitions to different sizes.
2. Do This 
````
VPart(top: {
    MyTopView()
    }, bottom: {
    MyBottomView()
    }) {
    MyHandle()
}
````

### Horizontal Partition 

1. Decide on what view you would like to have on `Left`, which you would like to have on the `Right` and optionally a `Handle` to be used to drag the partitions to different sizes.
2. Do This 
````
HPart(left: {
    MyLeftView()
    }, right: {
    MyRightView()
    }) {
    MyHandle()
}
````

### GridPartition 

1. Decide on what Views will go in each corner `TopLeft`, `TopRight`, `BottomLeft`, `BottomRight` and optionally a `Handle` for the user to drag and resize the views with. 
2. Do this 
````
    GridPart(topLeft: {
        MyTopLeftView()
        }, topRight: {
        MyTopRightView()
        }, bottomLeft: {
        MyBottomLeftView()
        }, bottomRight: {
        MyBottomRightView()
        }) {
        MyHandle()
}
````




## Examples 






## Todo 
* Add in constraints so that partitions will not cause negative frame values that invert the views when the handle is dragged beyond the frame of the container 
* Add more customizability to initial layouts 
* Add a `List` Style grid collection layout that can be initiated with a list of Identifiable data elements. 
* General cleanup, some stuff was not meant to be left in, i will find it at some point. 

