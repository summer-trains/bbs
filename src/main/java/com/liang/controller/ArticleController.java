package com.liang.controller;

import java.io.File;
import java.io.IOException;
import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.liang.bean.*;
import com.liang.service.*;
import org.apache.http.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

//引入文件路径类
import PicPath.PicPaths;

import com.liang.utils.PathUtil;
import word_filter.WordDetect;

@RequestMapping("/articleController")
@SessionAttributes(value= {"article_Edit"})
@Controller
public class ArticleController {

	@Autowired
	ArticleService articleService;
	@Autowired
	CommentService commentService;
	@Autowired
	CollectService collectService;
	@Autowired
	PlateService plateService;
	@Autowired
	AttentionService attentionService;
	
	/**
	 * 向数据库插入发帖信息（包括图片）
	 * 
	 * @param file
	 * @param article2
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/setArticle")
	//有MultipartFile file的时候不能有 Article article，因为Article中包含了文件（file）????!!!
	public String setArticle(@RequestParam("photo") MultipartFile file, Article2 article2, HttpSession session,HttpServletRequest request)
			throws IOException {

		//验证是否含有敏感词汇
		String contentText=article2.getFcontent();		//获取评论内容
		Set<String> sensiWord= WordDetect.getBadWord(contentText,2);		//最大匹配规则获取敏感词
		Iterator<String> iterator=sensiWord.iterator();

		String Sense="";
		//获取敏感词
		while(iterator.hasNext()){
			Sense=Sense+" ; "+iterator.next();
		}

		String projectname;	//项目名称
		projectname = request.getSession().getServletContext().getRealPath("/");
		projectname=projectname.substring(0,projectname.length()-1);
		if (projectname.indexOf("/")==-1) {//在非linux系统下
			projectname = projectname.substring(projectname.lastIndexOf("\\"),projectname.length());
		} else {//在linux系统下
			projectname = projectname.substring(projectname.lastIndexOf("/"),projectname.length());
		}
		System.out.println("项目名称:"+projectname);

		//文件（图片）路径
		//修改上传文件路径
		//String filePath = PathUtil.getCommonPath()+projectname+PathUtil.getArticlePath();
		//String filePath = PathUtil.getCommonPath()+projectname+"/statics/upload/article/";
		String filePath=PicPaths.PicPath;
		System.out.println(PathUtil.getCommonPath()+" is common path");
		System.out.println(projectname+"  is project name");
		//修改图片存放路径
		//String filePath=PicPaths.PicPath;
		//用于存放新生成的文件名字(不重复)
		String newFileName = "photo";
		
		String username=(String) session.getAttribute("username");
		Article article=null;
		//用户登录情况下才可发帖
		if(username!=null) {
			
			//当其中没有值时"int userid=null"报错(肯定报错啊，int=null???)
			int userid=(int)(Integer) session.getAttribute("userid");
			
			// 获取上传图片的文件名及其后缀(获取原始图片的拓展名)
			String fileName = file.getOriginalFilename();
			
			if(!fileName.equals("")) {
				//去掉中文字符
				fileName=subStrForMath(fileName);
				//生成新的文件名字(不重复)
				newFileName = UUID.randomUUID() + fileName;
				System.out.println("文件名称:"+fileName);
				System.out.println("文件路径"+filePath);
				
				// 封装上传文件位置的全路径
				File targetFile = new File(filePath, newFileName);
				System.out.println("封装上传文件位置的全路径:"+targetFile);
				// 把本地文件上传到封装上传文件位置
				file.transferTo(targetFile);
			}
			
			// 将article2和photo整合到article中
			article = new Article(article2, newFileName);

			article.setUserid(userid);
			article.setUsername(username);
			article.setStatus(0);

			// 将article保存到数据库
		}

		//不包含任何敏感词汇
		if(Sense.equals("")){
			System.out.println("文章不含敏感词汇");
			article.setStatus(1);
			request.getSession().setAttribute("SenseWord","");
		}
		else{
			//设置敏感词汇属性
			request.getSession().setAttribute("SenseWord",Sense);

			article.setStatus(0);
		}
		//保存到数据库
		articleService.setArticle(article);
		return "redirect:/myself.jsp";//重定向
	}

	/**
	 * 查询发帖表信息（首页-分页）
	 * @param map
	 * @return
	 */
	@RequestMapping("/getArticle")
	@ResponseBody
	public Map getArticle(Map<Object, Object> map, @RequestParam(required=true,defaultValue="1") int pageStart, @RequestParam(required=true,defaultValue="10")int pageSize) {
		Map<Object, Object> map2 = new HashMap<Object, Object>();
		List<Article> listArticle = articleService.getArticle(pageStart, pageSize);
		map.put("listArticle", listArticle);
		map.put("pageStart", pageStart);
		map2.put("pageStart", pageStart);
		return map2;
	}

	/**
	 * 查询发帖表信息（管理-分页）
	 * @param map
	 * @param pageStart
	 * @param pageSize
	 * @return
	 * my notes----
	 */
	@RequestMapping("/getArticleManagement")
	@ResponseBody
	public Map getArticleAdmin(Map<Object, Object> map, @RequestParam(required=true,defaultValue="1") int pageStart, @RequestParam(required=true,defaultValue="10")int pageSize) {
		Map<Object, Object> map2 = new HashMap<Object, Object>();
		int tail = 1;
		List<Article> listArticle = articleService.getArticleAdmin(pageStart, pageSize);
		// 总贴数
		int total = articleService.getCount();
		map.put("article_total",total);
		map2.put("article_total",total);
		map.put("article_pageStart", pageStart);
		map2.put("article_pageStart", pageStart);
		map.put("article_pageSize", pageSize);
		map2.put("article_pageSize", pageSize);
		map.put("listArticle", listArticle);
		map2.put("listArticle", listArticle);
		if (total % pageSize == 0){
			tail = total / pageSize;
			map.put("article_tail",tail);
			map2.put("article_tail",tail);
		} else {
			tail = (total / pageSize) +1;
			map.put("article_tail",tail);
			map2.put("article_tail",tail);
		}
		return map2;
	}
	
	/**
	 * 按帖子标题模糊查询（搜索框搜索）
	 * @param articleTitle
	 * @param map
	 */
	//@RequestMapping("/getArticleTitle")
	public Map getArticleTitle(String articleTitle,Map<Object, Object> map) {
		System.out.println("you click searches......."+articleTitle);
		List<Article> listArticle = articleService.getArticleTitle(articleTitle);
		map.put("listArticle", listArticle);
		System.out.println(listArticle.get(0).getTitles());
		return map;
	}
	
	/**
	 * 按帖子板块查询出帖子
	 * @param bname
	 * @param map
	 */
	public Map getArticleBname(String bname, Map<Object, Object> map) {
		System.out.println("search all plates..........");
		List<Article> listArticle = articleService.getArticleBname(bname);
		map.put("listArticle", listArticle);
		return map;
	}
	

	/**
	 * 按fid删除帖子
	 * @param fid
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("/deleteArticle/{fid}")
	@ResponseBody
	public Map deleteArticle(@PathVariable int fid,HttpServletRequest request) throws IOException {
		Map map = new HashMap();
		try {
			int count=commentService.getCommentFid(fid).size();

			//不能将commentService.getCommentFid(fid).size();放在for()里面，因为：
			//因为每一次commentService.deleteComment(pid)都会删除一条记录，总记录就会少一条，
			//自然commentService.getCommentFid(fid).size()就会减一。
			for(int i=0;i<count;i++) {

				//为啥用get(0)，而不用get(i)？
				//因为每一次commentService.deleteComment(pid)都会删除一条记录，总记录就会少一条，自然之前的get(1)就变成了现在的get(0)
				//以此递推，故为get(0)，而不是get(i);
				int pid=commentService.getCommentFid(fid).get(0).getPid();

				//删除帖子下对应的评论（注意：先删评论再删帖子！！）
				commentService.deleteComment(pid);
			}

			//调用删除帖子对应图片的方法
			articlePhotoDelete(fid,request);
			//删除帖子(数据库)
			articleService.deleteArticle(fid);

			//删除有该帖子id的收藏信息
			collectService.deleteCollectFid(fid);

			//删除该用户对应的收藏信息(按userid)
			collectService.deleteCollectFid(fid);

			map.put("resultCode",200);
		}catch (Exception e){
			map.put("resultCode",404);
		}

		return map;
	}
	
	/**
	 * 获取mycontent.jsp页面传来的数据，获取板块信息
	 * @param article
	 * @return
	 */
	@RequestMapping("/getUpdateArticle")
	@ResponseBody
	public Map getUpdateArticle(Article article) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("article_Edit", article);
		//无条件获取板块信息
		List<Plate> plate=plateService.getPlate();
		map.put("plate", plate);
		
		return map;
	}
	
	/**
	 * 修改帖子表
	 * @return
	 * @throws IOException 
	 */

	//去掉字符串中中文字符
	public String subStrForMath(String str){
		String string="";
		for (int i = 0; i < str.length(); i++){
			String str0="";
			if (str.substring(i, i + 1).matches("[\u4e00-\u9fa5]+")){
			}else{
				str0 = str.substring(i, i + 1) + "";
			}
			string +=str0;
		}
		return string;
	}


	@RequestMapping("/updateArticle")
	@ResponseBody
	public Map updateArticle(@RequestParam("photo") MultipartFile file, Article2 article2,HttpServletRequest request) {
		Map<Object, Object> map = new HashMap();
		try {
			String projectname;	//项目名称
			projectname = request.getSession().getServletContext().getRealPath("/");
			projectname=projectname.substring(0,projectname.length()-1);
			if (projectname.indexOf("/")==-1) {//在非linux系统下
				projectname = projectname.substring(projectname.lastIndexOf("\\"),projectname.length());
			} else {//在linux系统下
				projectname = projectname.substring(projectname.lastIndexOf("/"),projectname.length());
			}

			//文件（图片）路径
			String filePath = PathUtil.getCommonPath()+projectname+PathUtil.getArticlePath();

			int fid=article2.getFid();

			// 获取上传图片的文件名及其后缀(获取原始图片的拓展名)
			String fileName = file.getOriginalFilename();

			//去掉中文字符
			fileName=subStrForMath(fileName);

			//文件名过短
			if(fileName.length()<=1)
				fileName=UUID.randomUUID()+"";
			// 生成新的文件名字(不重复)
			String newFileName = UUID.randomUUID() + fileName;
			// 封装上传文件位置的全路径
			File targetFile = new File(filePath, newFileName);
			System.out.println("封装上传文件位置的全路径:"+targetFile);
			// 把本地文件上传到封装上传文件位置的全路径
			file.transferTo(targetFile);

			// 将article2和photo整合到article中
			Article article = new Article(article2, newFileName);

			//调用删除帖子对应图片的方法
			articlePhotoDelete(fid,request);
			//修改帖子表（数据库）
			articleService.updateArticle(article);

			map.put("resultCode",200);
		}catch (Exception e){
			map.put("resultCode",404);
		}

		return map;
	}
	
	
	/**
	 * 删除帖子对应的图片
	 * @throws IOException 
	 */
	public void articlePhotoDelete(int fid,HttpServletRequest request) throws IOException {
		
		String projectname;	//项目名称
		projectname = request.getSession().getServletContext().getRealPath("/");
		projectname=projectname.substring(0,projectname.length()-1);
		if (projectname.indexOf("/")==-1) {//在非linux系统下
			projectname = projectname.substring(projectname.lastIndexOf("\\"),projectname.length());
		} else {//在linux系统下
			projectname = projectname.substring(projectname.lastIndexOf("/"),projectname.length());
		}

		//文件（图片）路径
		//String filePath = PathUtil.getCommonPath()+projectname+PathUtil.getArticlePath();

		//修改后的文件路径
		String filePath=PicPaths.PicPath;
		
		// 获取取要删除帖子对应的图片的文件名（通过fid获取帖子信息）
		String fileName = articleService.getArticleKey(fid).getPhoto();
		// 封装上传文件位置的全路径
		File targetFile = new File(filePath, fileName);
		
		//删除帖子对应的图片（实际删除）
		targetFile.delete();
	}
	
	/**
	 * 修改article表的status属性（修改审核状态）
	 * @return
	 */
	@RequestMapping("/articleStatus")
	@ResponseBody
	public Map articleStatus(Article article) {
		Map<Object,Object> map = new HashMap<Object,Object>();
		try {
			articleService.updateArticleStatus(article);
			map.put("resultCode",200);
		} catch (Exception e){
			map.put("resultCode",404);
		}
		return map;
	}
	
	/**
	 * 按fid查询帖子信息（帖子展示）
	 * @return
	 */
	@RequestMapping("/getArticleFid/{fid}")
	@ResponseBody
	public Map getArticleFid(@PathVariable int fid) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		Article article = articleService.getArticleKey(fid);
		map.put("listArticle",article);
		// 再通过帖子的id查找出对应的评论信息
		commentService.getCommentFidMap(fid, map);
		// 将上一步查出的对应的评论信息存放到listComment里
		List<Comment> listComment = (List<Comment>) map.get("listComment");

		// 为map预设一个随帖子id变化而变化的key
		String listCommentFid = "listComment_" + fid;
		// 将帖子下对应的所有评论存入map中（其key是随帖子id变化而变化的）
		map.put(listCommentFid, listComment);
		//去除多余信息
		map.remove("listComment");

		// 查询板块信息（无条件）
		List<Plate> plate = plateService.getPlate();
		map.put("plate", plate);

		// 查询关注信息(无条件)
		List<Attention> attention = attentionService.getAttention();
		map.put("attention", attention);

		// 查询收藏信息（无条件）
		List<Collect> collect = collectService.getCollect();
		map.put("collect", collect);

		return map;
	}

	
}
