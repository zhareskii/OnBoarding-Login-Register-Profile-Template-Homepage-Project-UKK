<?php
namespace app\controllers\api;

use app\models\User;
use yii\rest\ActiveController;
use yii\web\Response;
use yii\filters\Cors;
use Yii;

class UserController extends ActiveController
{
    public $modelClass = 'app\models\User';
    
    public function init()
    {
        parent::init();
        
        // Set CORS headers di setiap request
        Yii::$app->response->headers->set('Access-Control-Allow-Origin', '*');
        Yii::$app->response->headers->set('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
        Yii::$app->response->headers->set('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept, Authorization, X-Requested-With');
        Yii::$app->response->headers->set('Access-Control-Allow-Credentials', 'true');
    }
    
    public function behaviors()
    {
        $behaviors = parent::behaviors();
        
        // Remove authentication
        unset($behaviors['authenticator']);
        
        // Set response format
        $behaviors['contentNegotiator']['formats']['text/html'] = Response::FORMAT_JSON;
        
        return $behaviors;
    }
    
    public function actions()
    {
        $actions = parent::actions();
        unset($actions['create']);
        unset($actions['update']);
        return $actions;
    }
    
    // Handle OPTIONS requests untuk CORS preflight
    public function actionOptions($id = null)
    {
        // Set CORS headers lagi untuk OPTIONS request
        Yii::$app->response->headers->set('Access-Control-Allow-Origin', '*');
        Yii::$app->response->headers->set('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
        Yii::$app->response->headers->set('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept, Authorization, X-Requested-With');
        Yii::$app->response->headers->set('Access-Control-Allow-Credentials', 'true');
        
        Yii::$app->response->setStatusCode(200);
        Yii::$app->end();
    }
    
    public function actionCreate()
    {
        // Set CORS headers
        Yii::$app->response->headers->set('Access-Control-Allow-Origin', '*');
        Yii::$app->response->headers->set('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
        Yii::$app->response->headers->set('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept, Authorization, X-Requested-With');
        
        Yii::$app->response->format = Response::FORMAT_JSON;
        
        $user = new User();
        $rawBody = Yii::$app->request->getRawBody();
        $postData = json_decode($rawBody, true);
        
        if ($postData) {
            $user->username = $postData['username'];
            $user->email = $postData['email'];
            $user->password = password_hash($postData['password'], PASSWORD_DEFAULT);
            $user->role = 'end_user';
            
            if ($user->save()) {
                return [
                    'status' => 'success', 
                    'message' => 'User created successfully',
                    'data' => $user
                ];
            } else {
                Yii::$app->response->statusCode = 422;
                return [
                    'status' => 'error', 
                    'message' => 'Validation failed',
                    'errors' => $user->errors
                ];
            }
        }
        
        Yii::$app->response->statusCode = 400;
        return ['status' => 'error', 'message' => 'No data received'];
    }
    
    public function actionUpdate($id)
    {
        // Set CORS headers
        Yii::$app->response->headers->set('Access-Control-Allow-Origin', '*');
        Yii::$app->response->headers->set('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
        Yii::$app->response->headers->set('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept, Authorization, X-Requested-With');
        
        Yii::$app->response->format = Response::FORMAT_JSON;
        
        $user = User::findOne($id);
        if (!$user) {
            Yii::$app->response->statusCode = 404;
            return ['status' => 'error', 'message' => 'User not found'];
        }
        
        $rawBody = Yii::$app->request->getRawBody();
        $putData = json_decode($rawBody, true);
        
        if ($putData) {
            if (isset($putData['username'])) $user->username = $putData['username'];
            if (isset($putData['email'])) $user->email = $putData['email'];
            if (isset($putData['password'])) $user->password = password_hash($putData['password'], PASSWORD_DEFAULT);
            
            if ($user->save()) {
                return [
                    'status' => 'success',
                    'message' => 'User updated successfully', 
                    'data' => $user
                ];
            } else {
                Yii::$app->response->statusCode = 422;
                return [
                    'status' => 'error',
                    'message' => 'Validation failed',
                    'errors' => $user->errors
                ];
            }
        }
        
        Yii::$app->response->statusCode = 400;
        return ['status' => 'error', 'message' => 'No data received'];
    }
    
    public function actionIndex()
    {
        // Set CORS headers untuk GET request
        Yii::$app->response->headers->set('Access-Control-Allow-Origin', '*');
        Yii::$app->response->headers->set('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
        Yii::$app->response->headers->set('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept, Authorization, X-Requested-With');
        
        $users = User::find()->all();
        return $users;
    }
}