using BitFaster.Caching;
using BitFaster.Caching.Lfu;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyboxICS.Services
{
    internal static class CacheManagementService
    {
        #region ::Constants::

        private const int CACHE_DEFAULT_CAPACITY = 1000;

        #endregion

        #region ::Variables::

        private static ConcurrentDictionary<string, IAsyncCache<string, byte[]>> _cahceStorage = new ConcurrentDictionary<string, IAsyncCache<string, byte[]>>();

        #endregion

        #region ::Service Logics::

        /// <summary>
        /// Creates a new cache in the cache storage.
        /// </summary>
        /// <param name="name">Sets the name of the cache.</param>
        /// <param name="capacity">Sets the maximum number of values to keep in the cache. If more items than this are added, the cache eviction policy will determine which values to remove.</param>
        /// <returns>A result boolean</returns>
        internal static bool CreateCache(string name, int capacity = CACHE_DEFAULT_CAPACITY)
        {
            bool result = false;

            var storage = new ConcurrentLfuBuilder<string, byte[]>()
                .WithCapacity(capacity)
                .WithAtomicGetOrAdd()
                .AsAsyncCache()
                .Build();

            /* ### LRU Cache Builder ###
            var storage = new ConcurrentLruBuilder<string, byte[]>()
                .WithCapacity(capacity)
                .WithAtomicGetOrAdd()
                .WithExpireAfterWrite(TimeSpan.FromMinutes(duration))
                .AsAsyncCache()
                .Build();
             */

            result = _cahceStorage.TryAdd(name, storage);

            return result;
        }

        /// <summary>
        /// Removes a cache from the cache storage.
        /// </summary>
        /// <param name="name">Sets the name of the cache.</param>
        /// <returns>A result boolean</returns>
        internal static bool RemoveCache(string name)
        {
            bool result = false;

            var cacheNames = _cahceStorage.Keys;

            for (int i=0; i< cacheNames.Count; i++)
            {
                if (string.Compare(name, cacheNames.ElementAt(i), true) == 0)
                {
                     result = _cahceStorage.TryRemove(_cahceStorage.ElementAt(i));
                }
            }

            return result;
        }

        /// <summary>
        /// Tries to get a cache from the cache storage.
        /// </summary>
        /// <param name="name">Sets the name of the cache.</param>
        /// <returns>An IAsyncCache</returns>
        internal static IAsyncCache<string, byte[]>? GetCache(string name)
        {
            IAsyncCache<string, byte[]>? cache = _cahceStorage.GetValueOrDefault(name);

            return cache;
        }

        /// <summary>
        /// Attempts to get a cache from the cache storage.
        /// </summary>
        /// <param name="name">Sets the name of the cache.</param>
        /// <param name="cache"></param>
        /// <returns>A result boolean</returns>
        internal static bool TryGetCache(string name, out IAsyncCache<string, byte[]>? cache)
        {
            IAsyncCache<string, byte[]>? tempCache = null;

            bool result = false;
            result = _cahceStorage.TryGetValue(name, out tempCache);

            cache = tempCache;
            return result;
        }

        /// <summary>
        /// Gets cache names from the cache storage.
        /// </summary>
        /// <returns>Cache names</returns>
        internal static List<string> GetCacheNames()
        {
            return _cahceStorage.Keys.ToList();
        }

        #endregion
    }
}
