/**
 *
 * <P> ThreadPoolUtil.java -- 线程池Util </p>
 * 
 *
 * @author 闫枫
 * @date Jan 4, 2017
 */
package com.unitever.platform.util;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 *
 * <P>
 * platform-daikuan->com.unitever.platform.util->ThreadPoolUtil.java
 * </p>
 * <P>
 * 线程池Util
 * </p>
 *
 * @author 闫枫
 * @date Jan 4, 2017
 */
public class ThreadPoolUtil {
	private static ExecutorService pool;

	static {
		pool = Executors.newCachedThreadPool();
	}

	/**
	 *
	 * <P>
	 * get线程池
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jan 4, 2017
	 * @return ExecutorService
	 */
	public static ExecutorService getPool() {
		return pool;
	}

}
