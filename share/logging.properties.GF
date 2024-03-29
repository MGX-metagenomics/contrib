#GlassFish logging.properties list
#Update Thu Mar 10 2010
#All attributes details
handlers=java.util.logging.ConsoleHandler
java.util.logging.ConsoleHandler.formatter=com.sun.enterprise.server.logging.UniformLogFormatter
com.sun.enterprise.server.logging.GFFileHandler.formatter=com.sun.enterprise.server.logging.UniformLogFormatter
com.sun.enterprise.server.logging.GFFileHandler.file=${com.sun.aas.instanceRoot}/logs/server.log
com.sun.enterprise.server.logging.GFFileHandler.rotationTimelimitInMinutes=0
com.sun.enterprise.server.logging.GFFileHandler.flushFrequency=1
java.util.logging.FileHandler.limit=50000
com.sun.enterprise.server.logging.GFFileHandler.logtoConsole=false
com.sun.enterprise.server.logging.GFFileHandler.rotationLimitInBytes=2000000
com.sun.enterprise.server.logging.SyslogHandler.useSystemLogging=false
java.util.logging.FileHandler.count=1
com.sun.enterprise.server.logging.GFFileHandler.retainErrorsStasticsForHours=0
log4j.logger.org.hibernate.validator.util.Version=warn
com.sun.enterprise.server.logging.GFFileHandler.maxHistoryFiles=7
com.sun.enterprise.server.logging.GFFileHandler.rotationOnDateChange=true
java.util.logging.FileHandler.pattern=%h/java%u.log
java.util.logging.FileHandler.formatter=java.util.logging.XMLFormatter
# Used for setting log record format values for setting log data under server.log file
# Generic Record Format: [#|yyyy-mm-ddTHH:mm:ss:SSS-ZZZZ|Level|ProductId|Logger Name|Name Value Pairs|MsgId: Message|#]
# User is allowed to change date format for recording data in server.log
com.sun.enterprise.server.logging.GFFileHandler.logFormatDateFormat=yyyy-MM-dd'T'HH:mm:ss.SSSZ

#All log level details
com.sun.enterprise.server.logging.GFFileHandler.level=ALL
javax.enterprise.system.tools.admin.level=INFO
org.apache.jasper.level=INFO
javax.enterprise.resource.corba.level=INFO
javax.enterprise.system.core.level=INFO
javax.enterprise.system.core.classloading.level=INFO
javax.enterprise.resource.jta.level=INFO
java.util.logging.ConsoleHandler.level=FINEST
javax.enterprise.system.webservices.saaj.level=INFO
javax.enterprise.system.tools.deployment.level=INFO
javax.enterprise.system.container.ejb.level=INFO
javax.enterprise.system.core.transaction.level=INFO
org.apache.catalina.level=INFO
javax.enterprise.system.container.ejb.mdb.level=INFO
org.apache.coyote.level=INFO
javax.level=INFO
javax.enterprise.resource.javamail.level=INFO
javax.enterprise.system.webservices.rpc.level=INFO
javax.enterprise.system.container.web.level=INFO
javax.enterprise.system.util.level=INFO
javax.enterprise.resource.resourceadapter.level=INFO
javax.enterprise.resource.jms.level=INFO
javax.enterprise.system.core.config.level=INFO
javax.enterprise.system.level=INFO
javax.enterprise.system.core.security.level=INFO
javax.enterprise.system.container.cmp.level=INFO
javax.enterprise.system.webservices.registry.level=INFO
javax.enterprise.system.core.selfmanagement.level=INFO
.level=INFO
javax.enterprise.resource.jdo.level=INFO
javax.enterprise.system.core.naming.level=INFO
javax.enterprise.resource.webcontainer.jsf.application.level=INFO
javax.enterprise.resource.webcontainer.jsf.resource.level=INFO
javax.enterprise.resource.webcontainer.jsf.config.level=INFO
javax.enterprise.resource.webcontainer.jsf.context.level=INFO
javax.enterprise.resource.webcontainer.jsf.facelets.level=INFO
javax.enterprise.resource.webcontainer.jsf.lifecycle.level=INFO
javax.enterprise.resource.webcontainer.jsf.managedbean.level=INFO
javax.enterprise.resource.webcontainer.jsf.renderkit.level=INFO
javax.enterprise.resource.webcontainer.jsf.taglib.level=INFO
javax.enterprise.resource.webcontainer.jsf.timing.level=INFO
javax.enterprise.resource.sqltrace.level=FINE
javax.org.glassfish.persistence.level=INFO
org.jvnet.hk2.osgiadapter.level=INFO
javax.enterprise.system.tools.backup.level=INFO
org.glassfish.admingui.level=INFO
javax.enterprise.system.ssl.security.level=INFO
ShoalLogger.level=CONFIG
org.eclipse.persistence.session.level=INFO
