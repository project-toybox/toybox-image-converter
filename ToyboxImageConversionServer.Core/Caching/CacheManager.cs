using BitFaster.Caching;
using BitFaster.Caching.Lru;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyboxImageConversionServer.Core.Caching
{
    public class CacheManager
    {
        public int Capacity { get; private set; }

        public IAsyncCache<string, byte[]> Storage { get; private set; }

        public CacheManager(int capacity, int duration = 10)
        {
            Capacity = capacity;
            Storage = new ConcurrentLruBuilder<string, byte[]>()
                .WithCapacity(capacity)
                .WithAtomicGetOrAdd()
                .WithExpireAfterWrite(TimeSpan.FromMinutes(duration))
                .AsAsyncCache()
                .Build();
        }
    }
}
