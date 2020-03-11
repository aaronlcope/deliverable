using System;
using Xunit;
using deliverable;
using dependency;

namespace deliverable.test
{
    public class ProgramTests
    {
        #region construction & formatting tests
        
        [Fact]
        public void ShouldPrintHelloAndWhatIFeedItSeparatedByAWhitespace()
        {
            var salutation = initSalutation();
            var result = salutation.Compose("there");
            Assert.StartsWith("Hello", result);
            Assert.EndsWith("there", result);
            var arr = result.Split(' ');
            Assert.Equal("Hello", arr[0]);
            Assert.Equal("there", arr[1]);
        }
        
        #endregion

        #region factories/helpers/initializers

        private Salutation initSalutation() {
            return new Salutation();
        }
        
        #endregion
    }
}
