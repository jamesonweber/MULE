//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MULE.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class mapping
    {
        public int mapping_id { get; set; }
        public int position_id { get; set; }
        public double echo_depth { get; set; }
    
        public virtual positioning positioning { get; set; }
    }
}