import org.apache.log4j.{Level, LogManager, PropertyConfigurator}
import org.apache.spark.{SparkContext, SparkConf}
import com.datastax.spark.connector._

object Links {

    val locale = new java.util.Locale("us", "US")
    val formatter = java.text.NumberFormat.getIntegerInstance(locale)

    def main(args: Array[String]) {

        val log = LogManager.getRootLogger
        log.setLevel(Level.WARN)

        val conf = new SparkConf(true)
            .setAppName("TotalLinksInDallas")
            .set("spark.cassandra.connection.host", "172.17.0.2")
        val sc = new SparkContext(conf)

        val rdd = sc.cassandraTable("cloud1", "links1")

        println("+-----------------------------------------+")
        println("|    Total New Links = " + rdd.count)
        println("+-----------------------------------------+")
        println(rdd.first)


        // println(rdd.map(_.getInt("url")).sum)
        // val result = table1.select("domain").groupBy("domain")
        // val df2 = df.select("domain", "total").filter("total > " + size).orderBy("total")
        // df2.collect().foreach { row => println(row.get(0)  + " " + row.get(1) ) }

        // df2.filter("count > 1000").collect().foreach(println)
        // csc.setKeyspace("engine")
        // df2.registerTempTable("table1")
        // csc.sql("SELECT * FROM table1").show()

        // println("--------------------------------------------------------------")
        // df2.collect().foreach { row => println(row.get(0)  + " " + row.get(1) ) }
        // println("--------------------------------------------------------------")

        sc.stop();

    }

}
